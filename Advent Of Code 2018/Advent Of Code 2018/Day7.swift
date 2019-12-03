//
//  Day7.swift
//  Advent Of Code 2018
//
//  Created by Trey Sands on 11/12/19.
//  Copyright © 2019 Trey Sands. All rights reserved.
//

import Foundation

class Day7 {
    struct Step {
        var blocks:Set<String> = Set()
        var isBlockedBy:Set<String> = Set()
    }
    
    static func main() {
        var tempUnblockedSet:Set<String> = Set()
        let pattern = #" (\D{1}) .* (\D{1}) "#
        let inputArray = Parser.arrayOfArrayOfStrings(from: "day_7_input", with: pattern, numberOfCaptures: 2)
        var steps:[String:Step] = [:]
        for input in inputArray {
            let newBlocker = input[0]
            let newBlocked = input[1]
            if let blocker = steps[newBlocker] {
                var newBlocks = blocker.blocks
                newBlocks.insert(newBlocked)
                steps[newBlocker] = Step(blocks: newBlocks, isBlockedBy: blocker.isBlockedBy)
                if blocker.isBlockedBy.count == 0 {
                    tempUnblockedSet.insert(newBlocker)
                } else {
                    tempUnblockedSet.remove(newBlocker)
                }
            } else {
                var newSet:Set<String> = Set()
                newSet.insert(newBlocked)
                steps[newBlocker] = Step(blocks: newSet, isBlockedBy: Set())
                tempUnblockedSet.insert(newBlocker)
            }
            
            if let blocked = steps[newBlocked] {
                var newIsBlockedBy = blocked.isBlockedBy
                newIsBlockedBy.insert(newBlocker)
                steps[newBlocked] = Step(blocks: blocked.blocks, isBlockedBy: newIsBlockedBy)
            } else {
                var newSet:Set<String> = Set()
                newSet.insert(newBlocker)
                steps[newBlocked] = Step(blocks: Set(), isBlockedBy: newSet)
            }
        }
        var unblockedSet = tempUnblockedSet
        var secondSteps = steps
        var turnString = ""
        
        while !unblockedSet.isEmpty {
            let first = unblockedSet.sorted().first!
            turnString.append(first)
            let step = steps[first]!
            let blocks = step.blocks
            for blocked in blocks {
                var tempStep = steps[blocked]!
                tempStep.isBlockedBy.remove(first)
                steps[blocked] = tempStep
                if tempStep.isBlockedBy.isEmpty {
                    unblockedSet.insert(blocked)
                }
            }
            unblockedSet.remove(first)
        }
        print("🇨🇦 Day 7 Part 1 Turn String is: \(turnString)")
        var newTurnString: String = ""
        var second = 0
        var workersDoneTime:[(Int, String)?] = Array(repeating: nil, count: 5)
        var addedSet:Set<String> = Set()
        
        while true {
            if (tempUnblockedSet.isEmpty && (workersDoneTime.filter({$0 == nil}).count == 5)) {
                break
            }
            for i in 0..<workersDoneTime.count {
                guard let work = workersDoneTime[i] else { continue }
                let time = work.0
                let turn = work.1
                if time == second {
                    newTurnString.append(turn)
                    workersDoneTime[i] = nil
                    let step = secondSteps[turn]!
                    let blocks = step.blocks
                    for blocked in blocks {
                        var tempStep = secondSteps[blocked]!
                        tempStep.isBlockedBy.remove(turn)
                        secondSteps[blocked] = tempStep
                        if tempStep.isBlockedBy.isEmpty {
                            tempUnblockedSet.insert(blocked)
                        }
                    }
                    tempUnblockedSet.remove(turn)
                    continue
                }
            }
            for turn in tempUnblockedSet.sorted() {
                if addedSet.contains(turn) {
                    continue
                }
                var wasAdded = false
                for i in 0..<workersDoneTime.count {
                    guard workersDoneTime[i] == nil else {
                        continue
                    }
                    workersDoneTime[i] = (second+Day7.time(for: turn), turn)
                    wasAdded = true
                    break
                }
                if wasAdded {
                    addedSet.insert(turn)
                }
            }
            
            second += 1
        }
        print("🇨🇦 Day 7 Part 2 Turn String is: \(newTurnString)")
        print("🇨🇦 Day 7 Part 2 Turn Seconds is: \(second-1)")
        
    }
    
    static private func time(for text:String) -> Int {
        switch text.lowercased() {
        case "a":
            return 61
        case "b":
            return 62
        case "c":
            return 63
        case "d":
            return 64
        case "e":
            return 65
        case "f":
            return 66
        case "g":
            return 67
        case "h":
            return 68
        case "i":
            return 69
        case "j":
            return 70
        case "k":
            return 71
        case "l":
            return 72
        case "m":
            return 73
        case "n":
            return 74
        case "o":
            return 75
        case "p":
            return 76
        case "q":
            return 77
        case "r":
            return 78
        case "s":
            return 79
        case "t":
            return 80
        case "u":
            return 81
        case "v":
            return 82
        case "w":
            return 83
        case "x":
            return 84
        case "y":
            return 85
        case "z":
            return 86
        default:
            return 0
        }
    }
    
}
