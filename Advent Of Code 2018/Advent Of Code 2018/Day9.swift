//
//  Day9.swift
//  Advent Of Code 2018
//
//  Created by Trey Sands on 11/15/19.
//  Copyright © 2019 Trey Sands. All rights reserved.
//

import Foundation

class Day9 {
    static let maxElves = 466
    var currentElf = 0
    var elfScores:[Int] = Array(repeating: 0, count: maxElves)
    let circle = Circle()
    static let finalMarble = 71436
    static let superMarble = 71436*100
    
    func main() {
        
        for i in 1...Day9.finalMarble {
            if let score = circle.add(marble: i) {
                elfScores[self.currentElf] += score
            }
            self.updateCurrentElf()
        }
        print("👹 Day 9 Part 1 High Score is: \(elfScores.max()!)")
        self.elfScores = Array(repeating: 0, count: Day9.maxElves)
        self.circle.reset()
        self.currentElf = 0
        for i in 1...Day9.superMarble {
            if let score = circle.add(marble: i) {
                elfScores[self.currentElf] += score
            }
            self.updateCurrentElf()
        }
        print("👹 Day 9 Part 2 High Score is: \(elfScores.max()!)")
    }
    
    private func updateCurrentElf() {
        self.currentElf += 1
        if currentElf == Day9.maxElves {
            self.currentElf = 0
        }
    }
}

class Circle {
    var array:[Int] = [0]
    private var currentMarble = 0
    
    func add(marble:Int) -> Int? {
        if marble % 23 == 0 {
            return self.add(specialMarble: marble)
        } else {
            self.add(normalMarble: marble)
            return nil
        }
        
    }
    
    func reset() {
        self.currentMarble = 0
        self.array = [0]
    }
    
    private func add(normalMarble: Int) {
        if array.count < 2 {
            self.array.append(normalMarble)
        } else if self.array.count+1 == self.currentMarble + 2 {
            self.array.append(normalMarble)
            self.currentMarble = self.array.count-1
        } else {
            let insertIndex = (currentMarble + 2) % self.array.count
            self.array.insert(normalMarble, at: insertIndex)
            self.currentMarble = insertIndex
        }
    }
    
    private func add(specialMarble: Int) -> Int {
        var removeIndex = self.currentMarble - 7
        if removeIndex < 0 {
            removeIndex = self.array.count + removeIndex
        }
        let returnScore = self.array[removeIndex]
        self.array.remove(at: removeIndex)
        self.currentMarble = removeIndex
        return returnScore + specialMarble
    }
}
