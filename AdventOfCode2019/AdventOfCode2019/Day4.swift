//
//  Day4.swift
//  AdventOfCode2019
//
//  Created by Trey Sands on 12/3/19.
//  Copyright © 2019 Trey Sands. All rights reserved.
//

import Foundation
class Day4 {
    let beginning = 178416
    let end = 676461
    
    func main() {
        self.part1()
        self.part2()
    }
    
    func part1() {
        var passwordWorks = 0
        for i in self.beginning ..< self.end {
            if rule1(number: i) && rule2(number: i) {
                passwordWorks += 1
            }
        }
        print("😡 Day 4 Part 1 total Passwords: \(passwordWorks)")
    }
    
    func part2() {
        var passwordWorks = 0
        for i in self.beginning ..< self.end {
            if rule1(number: i) && rule2(number: i) && rule3(number: i) {
                passwordWorks += 1
            }
        }
        print("😡 Day 4 Part 2 total Passwords: \(passwordWorks)") // 941, 940
    }
    
    func rule1(number:Int) -> Bool {
        let digits = number.digits
        for i in 0..<5 {
            if digits[i] == digits[i+1] {
                return true
            }
        }
        return false
    }
    
    func rule2(number:Int) -> Bool {
        let digits = number.digits
        for i in 0..<5 {
            if digits[i] > digits[i+1] {
                return false
            }
        }
        return true
    }
    
    func rule3(number:Int) -> Bool {
        let digits = number.digits
        var largeGroupDigit = -1
        var has2 = false
        for i in 0..<5 {
            if digits[i] == digits[i+1] {
                if i < 4 {
                    if digits[i+2] == digits[i] {
                        largeGroupDigit = digits[i]
                    }
                }
                if largeGroupDigit != digits[i] {
                    has2 = true
                }
            }
        }
        return has2
    }
}

extension StringProtocol  {
    var digits: [Int] { compactMap{ $0.wholeNumberValue } }
}
extension LosslessStringConvertible {
    var string: String { .init(self) }
}
extension Numeric where Self: LosslessStringConvertible {
    var digits: [Int] { string.digits }
}
