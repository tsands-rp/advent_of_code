//
//  Day5.swift
//  AdventOfCode2019
//
//  Created by Trey Sands on 12/4/19.
//  Copyright © 2019 Trey Sands. All rights reserved.
//

import Foundation

class Day5 {
    func main() {
        var memory:[Int] = []
        for char in day_5_input.split(separator: ",") {
            memory.append(Int(String(char))!)
        }
        self.part1(input: memory)
        self.part2(input: memory)
    }
    
    func part1(input:[Int]) {
        let computer = Computer(input: input)
        let _ = computer.run(input: 1)
    }
    
    func part2(input:[Int]) {
        let computer = Computer(input: input)
        let _ = computer.run(input: 5)
    }
}
