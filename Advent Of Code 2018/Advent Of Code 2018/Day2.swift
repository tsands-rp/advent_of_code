//
//  Day2.swift
//  Advent Of Code 2018
//
//  Created by Trey Sands on 11/6/19.
//  Copyright © 2019 Trey Sands. All rights reserved.
//

import Foundation

class Day2 {
    static func main() {
        let input = Parser.arrayOfStrings(from: "day_2_input")
        var numberOfDoubles = 0
        var numberOfTriples = 0
        for s in input {
            var countOfCharactersDict:[Character:Int] = [:]
            for char in s {
                if let count = countOfCharactersDict[char] {
                    countOfCharactersDict[char] = count + 1
                } else {
                    countOfCharactersDict[char] = 1
                }
            }
            let countOfCharactersSet = Set(countOfCharactersDict.values)
            if countOfCharactersSet.contains(2) {
                numberOfDoubles += 1
            }
            if countOfCharactersSet.contains(3) {
                numberOfTriples += 1
            }
        }
        print("🏟 DAY 2 PART 1 DOUBLES: \(numberOfDoubles)")
        print("🏟 DAY 2 PART 1 TRIPLES: \(numberOfTriples)")
        print("🏟 DAY 2 PART 1 CHECKSUM: \(numberOfDoubles*numberOfTriples)")
        for (index, currentString) in input.enumerated() {
            let remainingStrings = input.dropFirst(index)
            let arrayString1 = Array(currentString)
            for laterString in remainingStrings {
                let arrayString2 = Array(laterString)
                var sameString:String = ""
                for (index2, _) in currentString.enumerated() {
                    let char1 = arrayString1[index2]
                    let char2 = arrayString2[index2]
                    if char1 == char2 {
                        sameString.append(char1)
                    }
                }
                if currentString.count - sameString.count == 1 {
                    print("🏟 DAY 2 PART 2 STRING 1: \(currentString)")
                    print("🏟 DAY 2 PART 2 STRING 2: \(laterString)")
                    print("🏟 DAY 2 PART 2 SAME STRING: \(sameString)")
                    return
                }
            }
        }
    }
}


