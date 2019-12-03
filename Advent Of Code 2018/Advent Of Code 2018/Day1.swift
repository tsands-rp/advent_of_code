//
//  Day1.swift
//  Advent Of Code 2018
//
//  Created by Trey Sands on 11/6/19.
//  Copyright © 2019 Trey Sands. All rights reserved.
//

import Foundation

class Day1 {
    static func main() {
        let strings = Parser.arrayOfStrings(from: "day_1_input")
        let input = strings.map { Int($0)!}
        var sum = 0
        for i in input {
            sum += i
        }
        print("🌈 DAY 1 PART 1 SUM: \(sum)")
        var seenFrequencies = Set<Int>()
        var currentFrequency = 0
        var hasNotSeenSameFrequency = true
        while hasNotSeenSameFrequency {
            for i in input {
                currentFrequency += i
                guard !seenFrequencies.contains(currentFrequency) else {
                    hasNotSeenSameFrequency = false
                    break
                }
                seenFrequencies.insert(currentFrequency)
            }
        }
        print("🌈 DAY 1 PART 2 SUM: \(currentFrequency)")
    }
}

