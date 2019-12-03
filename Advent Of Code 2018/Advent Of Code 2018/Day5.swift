//
//  Day5.swift
//  Advent Of Code 2018
//
//  Created by Trey Sands on 11/12/19.
//  Copyright © 2019 Trey Sands. All rights reserved.
//

import Foundation
class Day5 {
    static func main() {
        var inputArray = Array(day_5_input)
        var currentIndex = 0
        while currentIndex <= inputArray.count-3 {
            for i in currentIndex..<inputArray.count-1 {
                if (inputArray[i].lowercased() == inputArray[i+1].lowercased()) && (inputArray[i].isLowercase != inputArray[i+1].isLowercase) {
                    inputArray.remove(at: i)
                    inputArray.remove(at: i)
                    if i == 0 { break }
                    currentIndex = i - 1
                    break
                }
                currentIndex = i
            }
        }
        print("👻 Day 5 Part 1 Polymer Length is \(inputArray.count)")
        var shortestPolymer = 100000000000000000
        for c in "qwertyuioplkjhgfdsazxcvbnm" {
            let polymerLength = Day5.react(removing: c.lowercased())
            if polymerLength < shortestPolymer {
                shortestPolymer = polymerLength
            }
        }
        print("👻 Day 5 Part 2 Polymer Length is \(shortestPolymer)")
    }
    
    static private func react(removing polymer:String) -> Int {
        let inputArray = Array(day_5_input)
        var fixedArray:[String.Element] = []
        for i in inputArray {
            if i.lowercased() != polymer {
                fixedArray.append(i)
            }
        }
        var currentIndex = 0
        while currentIndex <= fixedArray.count-3 {
            for i in currentIndex..<fixedArray.count-1 {
                if (fixedArray[i].lowercased() == fixedArray[i+1].lowercased()) && (fixedArray[i].isLowercase != fixedArray[i+1].isLowercase) {
                    fixedArray.remove(at: i)
                    fixedArray.remove(at: i)
                    if i == 0 { break }
                    currentIndex = i - 1
                    break
                }
                currentIndex = i
            }
        }
        return fixedArray.count
    }
}
