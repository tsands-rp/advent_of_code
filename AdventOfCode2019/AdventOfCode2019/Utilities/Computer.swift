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
    
    private var currentAddress: Int = 0
    
    init(input:[Int]) {
        self.input = input
    }
    
    func reset() {
        self.currentMemory = input
        self.currentAddress = 0
    }
    
    func resetAndChangeInput(first: Int, second: Int) {
        self.reset()
        self.currentMemory[1] = first
        self.currentMemory[2] = second
    }
    
    func run() -> Int {
        mainLoop: while true {
            let instruction = self.currentMemory[self.currentAddress]
            switch instruction {
            case 1:
                self.opcode1()
            case 2:
                self.opcode2()
            case 99:
                break mainLoop
            default:
                print("wut: \(instruction)")
            }
        }
        return self.currentMemory[0]
    }
    
    private func opcode1() {
        let currentIndex = self.currentAddress
        let firstIndex = currentIndex + 1
        let secondIndex = currentIndex + 2
        let thirdIndex = currentIndex + 3
        let firstValueIndex = self.currentMemory[firstIndex]
        let secondValueIndex = self.currentMemory[secondIndex]
        let firstValue = self.currentMemory[firstValueIndex]
        let secondValue = self.currentMemory[secondValueIndex]
        let resultIndex = self.currentMemory[thirdIndex]
        self.currentMemory[resultIndex] = firstValue + secondValue
        self.currentAddress = currentIndex + 4
    }
    
    private func opcode2() {
        let currentIndex = self.currentAddress
        let firstIndex = currentIndex + 1
        let secondIndex = currentIndex + 2
        let thirdIndex = currentIndex + 3
        let firstValueIndex = self.currentMemory[firstIndex]
        let secondValueIndex = self.currentMemory[secondIndex]
        let firstValue = self.currentMemory[firstValueIndex]
        let secondValue = self.currentMemory[secondValueIndex]
        let resultIndex = self.currentMemory[thirdIndex]
        self.currentMemory[resultIndex] = firstValue * secondValue
        self.currentAddress = currentIndex + 4
    }
}
