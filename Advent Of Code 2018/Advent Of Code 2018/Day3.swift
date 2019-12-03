//
//  Day3.swift
//  Advent Of Code 2018
//
//  Created by Trey Sands on 11/7/19.
//  Copyright © 2019 Trey Sands. All rights reserved.
//

import Foundation
class Day3 {
    struct PossibleSquares {
        var squares:[Int] = []
        var hasEnough:Bool = false
    }
    static func main() {
        var matrix:[[Int]] = Array(repeating: Array(repeating: 0, count: 1000), count: 1000)
        var matrixOfSquaresArrayDict:[Int:[Int:PossibleSquares]] = [0:[0:PossibleSquares()]]
        var numberOfCutOutAlready = 0
        var setOfPossibleSquares = Set(1..<1000)
        let inputArray = Parser.arrayOfArrayOfStrings(from: "day_3_input", with: #"#(\d*+) @ (\d*+),(\d*+): (\d*)x(\d*+)"#, numberOfCaptures: 5)
        for inputString in inputArray {
            let square = Int(inputString[0])!
            let x = Int(inputString[1])!
            let y = Int(inputString[2])!
            let width = Int(inputString[3])!
            let height = Int(inputString[4])!
            for tempX in x..<x+width {
                for tempY in y..<y+height {
                    let count = matrix[tempX][tempY]
                    matrix[tempX][tempY] = count + 1
                    if count == 1 {
                        numberOfCutOutAlready += 1
                    }
                    guard let tempYDict = matrixOfSquaresArrayDict[tempX] else {
                        matrixOfSquaresArrayDict[tempX] = [tempY:PossibleSquares(squares: [square], hasEnough: false)]
                        continue
                    }
                    guard var possibleSquares = tempYDict[tempY] else {
                        matrixOfSquaresArrayDict[tempX]![tempY] = PossibleSquares(squares: [square], hasEnough: false)
                        continue
                    }
                    possibleSquares.squares.append(square)
                    if possibleSquares.hasEnough {
                        setOfPossibleSquares.remove(square)
                    } else if possibleSquares.squares.count == 2 {
                        possibleSquares.hasEnough = true
                        setOfPossibleSquares.remove(possibleSquares.squares[0])
                        setOfPossibleSquares.remove(square)
                    }
                    matrixOfSquaresArrayDict[tempX]![tempY]! = possibleSquares
                }
            }
        }
        print("🐕 DAY 3 PART 1 number of square inches: \(numberOfCutOutAlready)")
        print("🐕 DAY 3 PART 1 square: \(setOfPossibleSquares)")
    }
}
