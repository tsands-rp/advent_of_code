//
//  Day4.swift
//  Advent Of Code 2018
//
//  Created by Trey Sands on 11/7/19.
//  Copyright © 2019 Trey Sands. All rights reserved.
//

import Foundation
//[1518-11-22 00:49] wakes up
//[1518-05-18 00:01] Guard #1171 begins shift
//[1518-11-20 00:28] wakes up
//[1518-10-27 00:37] wakes up
struct TimeLog {
    //    let date:Date
    let year: Int
    let month: Int
    let day: Int
    let hour: Int
    let minute: Int
    let message: String
}
extension TimeLog: Comparable {
    static func < (lhs: TimeLog, rhs: TimeLog) -> Bool {
        if lhs.year < rhs.year {
            return true
        } else if lhs.year > rhs.year {
            return false
        }
        
        if lhs.month < rhs.month {
            return true
        } else if lhs.month > rhs.month {
            return false
        }
        
        if lhs.day < rhs.day {
            return true
        } else if lhs.day > rhs.day {
            return false
        }
        //        var tempLHSHour = lhs.hour
        //        var tempRHSHour = rhs.hour
        //        if lhs.hour == 0 {
        //            tempLHSHour
        //        }
        if lhs.hour < rhs.hour {
            return true
        } else if lhs.hour > rhs.hour {
            return false
        }
        
        if lhs.minute < rhs.minute {
            return true
        } else if lhs.minute > rhs.minute {
            return false
        }
        
        return true
    }
}

struct GuardLog {
    let guardName: String
    var totalAsleep = 0
    var minutesAsleep:[Int] = Array(repeating: 0, count: 60)
}
class Day4 {
    static func main() {
        //        #"#(\d*+) @ (\d*+),(\d*+): (\d*)x(\d*+)"#
        let pattern = #"(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2})] (.*)"#
        let inputArray = Parser.arrayOfArrayOfStrings(from: "day_4_input", with: pattern, numberOfCaptures: 6)
        var timeLogs:[TimeLog] = []
        for inputStringArray in inputArray {
            let year = Int(inputStringArray[0])!
            let month = Int(inputStringArray[1])!
            let day = Int(inputStringArray[2])!
            let hour = Int(inputStringArray[3])!
            let minute = Int(inputStringArray[4])!
            let message = inputStringArray[5]
            timeLogs.append(TimeLog(year: year, month: month, day: day, hour: hour, minute: minute, message: message))
        }
        timeLogs.sort()
        var guardLogDict:[String:GuardLog] = [:]
        var currentGuard: String = ""
        var minuteAsleep:Int? = nil
        for i in 0..<timeLogs.count {
            if let guardName = Parser.guardName(from: timeLogs[i].message) {
                currentGuard = guardName
                continue
            }
            guard let tempMinuteAsleep = minuteAsleep else {
                minuteAsleep = timeLogs[i].minute
                continue
            }
            
            let minuteAwake = timeLogs[i].minute
            let timeAsleep = minuteAwake - tempMinuteAsleep
            guard var guardLog = guardLogDict[currentGuard] else {
                var guardLog = GuardLog(guardName: currentGuard)
                guardLog.totalAsleep += timeAsleep
                for i in tempMinuteAsleep..<minuteAwake {
                    guardLog.minutesAsleep[i] = guardLog.minutesAsleep[i] + 1
                }
                guardLogDict[currentGuard] = guardLog
                minuteAsleep = nil
                continue
            }
            guardLog.totalAsleep = timeAsleep
            
            for i in tempMinuteAsleep..<minuteAwake {
                guardLog.minutesAsleep[i] = guardLog.minutesAsleep[i] + 1
            }
            guardLogDict[currentGuard] = guardLog
            minuteAsleep = nil
        }
        var guardMessage = ""
        var longestLog: GuardLog?
        for (message, log) in guardLogDict {
            if log.totalAsleep > longestLog?.totalAsleep ?? 0 {
                guardMessage = message
                longestLog = log
            }
        }
        var bestMinute = 0
        var mostAsleepMinutes = 0
        for i in 0..<60 {
            if longestLog!.minutesAsleep[i] > mostAsleepMinutes {
                bestMinute = i
                mostAsleepMinutes = longestLog!.minutesAsleep[i]
            }
        }
        print("🍳 Day 4 Part 1 Guard Message is: \(guardMessage)")
        print("🍳 Day 4 Part 1 Minute is: \(bestMinute)")
        print("🍳 Day 4 Part 1 Product is: \(Int(guardMessage)!*bestMinute)")
        var bestMinute2: Int = 0
        var highestFrequency: Int = 0
        var worstGuard: String = ""
        for guardLog in guardLogDict.values {
            var tempBestMinute: Int = 0
            var tempHighestFrequency: Int = 0
            for i in 0..<guardLog.minutesAsleep.count {
                if guardLog.minutesAsleep[i] > tempHighestFrequency {
                    tempHighestFrequency = guardLog.minutesAsleep[i]
                    tempBestMinute = i
                }
            }
            if tempHighestFrequency > highestFrequency {
                highestFrequency = tempHighestFrequency
                bestMinute2 = tempBestMinute
                worstGuard = guardLog.guardName
            }
        }
        print("🍳 Day 4 Part 2 Guard Message is: \(worstGuard)")
        print("🍳 Day 4 Part 2 Minute is: \(bestMinute2)")
        print("🍳 Day 4 Part 2 Product is: \(Int(worstGuard)!*bestMinute2)")
    }
    struct Guard{
    
    }
}

private extension Parser {
    static func guardName(from inputString:String) -> String? {
        let pattern = #"Guard #(\d{3,4})"#
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let range = NSRange(inputString.startIndex..<inputString.endIndex, in: inputString)
            var guardName: String? = nil
            regex.enumerateMatches(in: inputString, options: [], range: range) { match, _, stop in
                guard let match = match, let range = Range(match.range(at: 1), in: inputString) else {
                    return
                }
                guardName = String(inputString[range])
            }
            return guardName
        }
        catch {
            return nil
        }
    }
}
