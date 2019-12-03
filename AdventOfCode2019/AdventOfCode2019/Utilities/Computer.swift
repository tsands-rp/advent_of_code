//
//  Computer.swift
//  AdventOfCode2019
//
//  Created by Trey Sands on 12/2/19.
//  Copyright © 2019 Trey Sands. All rights reserved.
//

import Foundation

class Computer {
    private let input: [Int]
    
    private lazy var currentMemory: [Int] = {
        return self.input
    }()
    
    init(input:[Int]) {
        self.input = input
    }
    
    func reset() {
        self.currentMemory = input
    }
    
    func resetAndChangeInput(first: Int, second: Int) {
        self.reset()
        self.currentMemory[1] = first
        self.currentMemory[2] = second
    }
    
    func run() -> Int {
        var currentOpCodeIndex = 0
        while true {
            let currentOpCode = self.input[currentOpCodeIndex]
            if currentOpCode == 1 {
                self.opcode1(currentOpCodeIndex)
                currentOpCodeIndex += 4
            } else if currentOpCode == 2 {
                self.opcode2(currentOpCodeIndex)
                currentOpCodeIndex += 4
            } else if currentOpCode == 99 {
                break
            } else {
              print("wut")
            }
        }
        return self.currentMemory[0]
    }
    
    private func opcode1(_ currentIndex: Int) {
        let firstIndex = currentIndex + 1
        let secondIndex = currentIndex + 2
        let thirdIndex = currentIndex + 3
        let firstValueIndex = self.currentMemory[firstIndex]
        let secondValueIndex = self.currentMemory[secondIndex]
        let firstValue = self.currentMemory[firstValueIndex]
        let secondValue = self.currentMemory[secondValueIndex]
        let resultIndex = self.currentMemory[thirdIndex]
        self.currentMemory[resultIndex] = firstValue + secondValue
    }
    
    private func opcode2(_ currentIndex: Int) {
        let firstIndex = currentIndex + 1
        let secondIndex = currentIndex + 2
        let thirdIndex = currentIndex + 3
        let firstValueIndex = self.currentMemory[firstIndex]
        let secondValueIndex = self.currentMemory[secondIndex]
        let firstValue = self.currentMemory[firstValueIndex]
        let secondValue = self.currentMemory[secondValueIndex]
        let resultIndex = self.currentMemory[thirdIndex]
        self.currentMemory[resultIndex] = firstValue * secondValue
    }
}
