//
//  Day2.swift
//  AdventOfCode2019
//
//  Created by Trey Sands on 12/2/19.
//  Copyright © 2019 Trey Sands. All rights reserved.
//

import Foundation
class Day2 {
    func main() {
        var memory:[Int] = []
        for char in day_2_input.split(separator: ",") {
            memory.append(Int(String(char))!)
        }
        self.part1(input: memory)
        self.part2(input: memory)
    }
    
    func part1(input:[Int]) {
        let computer = Computer(input: input)
        computer.resetAndChangeInput(first: 12, second: 2)
        let result = computer.run(input: 0)
        print("🕹 Day 2 Part 1 Total: \(result)")
    }
    
    func part2(input:[Int])  {
        let computer = Computer(input: input)
        for first in 0...99 {
            for second in 0...99 {
                computer.resetAndChangeInput(first: first, second: second)
                let result = computer.run(input: 0)
                if result == 19690720 {
                    print("🕹 Day 2 Part 2 Total: \(100*first + second)")
                    return
                }
            }
        }
    }
}
