//
//  Day2.swift
//  AdventOfCode2019
//
//  Created by Trey Sands on 12/2/19.
//  Copyright © 2019 Trey Sands. All rights reserved.
//

import Foundation
class Day2 {
    var input:[Int] = []
    
    func main() {
        var memory:[Int] = []
        for char in day_2_input.split(separator: ",") {
            memory.append(Int(String(char))!)
        }
        memory[1] = 12
        memory[2] = 2
        
        self.input = memory
        self.part1(input: memory)
        self.part2(input: memory)
    }
    
    func part1(input:[Int]) {
        let computer = Computer(input: input)
        let result = computer.run()
        print("🕹 Day 2 Part 1 Total: \(result)")
    }
    
    func part2(input:[Int])  {
        let computer = Computer(input: input)
        for first in 0...99 {
            for second in 0...99 {
                computer.resetAndChangeInput(first: first, second: second)
                let result = computer.run()
                if result == 19690720 {
                    print("🕹 Day 2 Part 2 Total: \(100*first + second)")
                    return
                }
            }
        }
    }
    
    
}
