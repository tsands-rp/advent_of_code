//
//  Day1.swift
//  AdventOfCode2019
//
//  Created by Trey Sands on 12/2/19.
//  Copyright © 2019 Trey Sands. All rights reserved.
//

import Foundation

class Day1 {
    let input:[Int] = Parser.arrayOfStrings(from: "day1").map { Int($0)!}
    
    func main() {
        self.part1()
        self.part2()
    }
    
    private func part1() {
        var totalFuel = 0
        for i in input {
            totalFuel += self.getFuel(for: i)
        }
        print("😈 Day 1 Part 1: Total fuel: \(totalFuel)")
    }
    
    private func part2() {
        var totalFuel = 0
        for i in input {
            totalFuel += self.getFuelRecursively(for: i)
        }
        print("😈 Day 1 Part 2: Total fuel: \(totalFuel)")
    }
    private func getFuel(for mass: Int) -> Int {
        let divisor = mass/3
        return divisor - 2
    }
    
    private func getFuelRecursively(for mass: Int) -> Int {
        let divisor = mass/3
        let fuelNeeded = divisor - 2
        return fuelNeeded > 0 ? fuelNeeded + self.getFuelRecursively(for: fuelNeeded) : 0
    }
}
