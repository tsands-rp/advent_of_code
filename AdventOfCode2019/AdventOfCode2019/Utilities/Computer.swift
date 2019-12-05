//
//  Computer.swift
//  AdventOfCode2019
//
//  Created by Trey Sands on 12/2/19.
//  Copyright © 2019 Trey Sands. All rights reserved.
//

import Foundation

fileprivate enum ParameterMode: Int {
    case position = 0
    case immediate = 1
}

fileprivate enum OpCode: Int {
    case add = 1
    case multiply = 2
    case input = 3
    case output = 4
    case skipIfTrue = 5
    case skipIfFalse = 6
    case isLessThan = 7
    case isEqualTo = 8
    case stop = 99
    
    var parameterCount: Int {
        switch self {
        case .add: return 3
        case .multiply: return 3
        case .input: return 1
        case .output: return 1
        case .skipIfTrue: return 2
        case .skipIfFalse: return 2
        case .isLessThan: return 3
        case .isEqualTo: return 3
        case .stop: return 0
        }
    }
}

fileprivate struct Instruction {
    let opCode: OpCode
    let parameterModes: [ParameterMode]
}

class Computer {
    private let input: [Int]
    
    private var currentMemory: [Int]
    
    private var currentAddress: Int = 0
    
    init(input:[Int]) {
        self.input = input
        self.currentMemory = input
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
    
    func run(input:Int) -> Int {
        mainLoop: while true {
            let instruction = self.parse(self.currentMemory[self.currentAddress])
            switch instruction.opCode {
            case .add:
                self.add(modes: instruction.parameterModes)
            case .multiply:
                self.multiply(modes: instruction.parameterModes)
            case .input:
                self.input(input: input)
            case .output:
                self.output(modes: instruction.parameterModes)
            case .skipIfTrue:
                self.skipIfTrue(modes: instruction.parameterModes)
            case .skipIfFalse:
                self.skipIfFalse(modes: instruction.parameterModes)
            case .isLessThan:
                self.isLessThan(modes: instruction.parameterModes)
            case .isEqualTo:
                self.isEqualTo(modes: instruction.parameterModes)
            case .stop:
                break mainLoop
            }
        }
        return self.currentMemory[0]
    }
    
    private func add(modes: [ParameterMode]) {
        let currentIndex = self.currentAddress
        let resultIndex = self.currentMemory[currentIndex+3]
        
        let firstValue = Computer.value(for: modes[0], at: self.currentMemory[currentIndex+1], in: self.currentMemory)
        let secondValue = Computer.value(for: modes[1], at: self.currentMemory[currentIndex+2], in: self.currentMemory)
        
        self.currentMemory[resultIndex] = firstValue + secondValue
        self.currentAddress = currentIndex + OpCode.add.parameterCount + 1
    }
    
    private func multiply(modes: [ParameterMode]) {
        let currentIndex = self.currentAddress
        let resultIndex = self.currentMemory[currentIndex+3]
        let firstValue = Computer.value(for: modes[0], at: self.currentMemory[currentIndex+1], in: self.currentMemory)
        let secondValue = Computer.value(for: modes[1], at: self.currentMemory[currentIndex+2], in: self.currentMemory)
        
        self.currentMemory[resultIndex] = firstValue * secondValue
        self.currentAddress = currentIndex + OpCode.multiply.parameterCount + 1
    }
    
    private func input(input: Int) {
        let currentIndex = self.currentAddress
        let resultIndex = self.currentMemory[currentIndex+1]
        self.currentMemory[resultIndex] = input
        self.currentAddress = currentIndex + OpCode.input.parameterCount + 1
    }
    
    private func output(modes:[ParameterMode]) {
        let currentIndex = self.currentAddress
        let outputIndex = self.currentMemory[currentIndex + 1]
        switch modes[0] {
        case .position:
            print("OUTPUT IS: \(self.currentMemory[outputIndex])")
        case .immediate:
            print("OUTPUT IS: \(outputIndex)")
        }
        self.currentAddress = currentIndex + OpCode.output.parameterCount + 1
    }
    
    private func skipIfTrue(modes:[ParameterMode]) {
        let currentIndex = self.currentAddress
        let firstValue = Computer.value(for: modes[0], at: self.currentMemory[currentIndex+1], in: self.currentMemory)
        let secondValue = Computer.value(for: modes[1], at: self.currentMemory[currentIndex+2], in: self.currentMemory)
        
        self.currentAddress = firstValue != 0 ? secondValue : currentIndex + OpCode.skipIfTrue.parameterCount + 1
    }
    
    private func skipIfFalse(modes:[ParameterMode]) {
        let currentIndex = self.currentAddress
        let firstValue = Computer.value(for: modes[0], at: self.currentMemory[currentIndex+1], in: self.currentMemory)
        let secondValue = Computer.value(for: modes[1], at: self.currentMemory[currentIndex+2], in: self.currentMemory)
        
        self.currentAddress = firstValue == 0 ? secondValue : currentIndex + OpCode.skipIfFalse.parameterCount + 1
    }
    
    private func isLessThan(modes:[ParameterMode]) {
        let currentIndex = self.currentAddress
        let resultIndex = self.currentMemory[currentIndex+3]
        let firstValue = Computer.value(for: modes[0], at: self.currentMemory[currentIndex+1], in: self.currentMemory)
        let secondValue = Computer.value(for: modes[1], at: self.currentMemory[currentIndex+2], in: self.currentMemory)
    
        self.currentMemory[resultIndex] = firstValue < secondValue ? 1 : 0
        self.currentAddress = currentIndex + OpCode.isLessThan.parameterCount + 1
    }
    
    private func isEqualTo(modes:[ParameterMode]) {
        let currentIndex = self.currentAddress
        let resultIndex = self.currentMemory[currentIndex+3]
        let firstValue = Computer.value(for: modes[0], at: self.currentMemory[currentIndex+1], in: self.currentMemory)
        let secondValue = Computer.value(for: modes[1], at: self.currentMemory[currentIndex+2], in: self.currentMemory)
        
        self.currentMemory[resultIndex] = firstValue == secondValue ? 1 : 0
        self.currentAddress = currentIndex + OpCode.isEqualTo.parameterCount + 1
    }
    
    static private func value(for mode:ParameterMode, at address:Int, in memory: [Int]) -> Int {
        switch mode {
        case .position: return memory[address]
        case .immediate: return address
        }
    }
    
    private func parse(_ instruction:Int) -> Instruction {
        let opCode = OpCode(rawValue: instruction % 100)!
        var parameterModes: [ParameterMode] = []
        for i in 0..<opCode.parameterCount {
            let mode = instruction / (10**(2+i)) % 10
            parameterModes.append(ParameterMode(rawValue: mode)!)
        }
        return Instruction(opCode: opCode, parameterModes: parameterModes)
    }
}

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ** : PowerPrecedence
func ** (radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}


