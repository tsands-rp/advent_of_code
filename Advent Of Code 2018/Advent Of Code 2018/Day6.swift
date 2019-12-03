//
//  Day6.swift
//  Advent Of Code 2018
//
//  Created by Trey Sands on 11/12/19.
//  Copyright © 2019 Trey Sands. All rights reserved.
//

import Foundation
class Day6 {
    struct Point: Hashable {
        let x: Int
        let y: Int
    }
    static func main() {
        let pattern = #"(\d*), (\d*)"#
        let inputArray = Parser.arrayOfArrayOfStrings(from: "day_6_input", with: pattern, numberOfCaptures: 2)
        var points:[Point] = []
        for input in inputArray {
            let x = Int(input[0])!
            let y = Int(input[1])!
            points.append(Point(x: x, y: y))
        }
        var infiniteAreaIndexes:Set<Int> = Set()
        var areas:[Int] = Array(repeating: 0, count: points.count)
        for x in 0..<400 {
            for y in 0..<400 {
                let tempPoint = Point(x: x, y: y)
                var minDistance = 100000
                var minPointIndex: Int? = nil
                for inputPointIndex in 0..<points.count {
                    let distance = Day6.manhattanDistance(from: tempPoint, to: points[inputPointIndex])
                    if distance < minDistance {
                        minDistance = distance
                        minPointIndex = inputPointIndex
                    } else if distance == minDistance {
                        minPointIndex = nil
                    }
                }
                guard let trueMinPointIndex = minPointIndex else { continue }
                areas[trueMinPointIndex] += 1
                if x == 0 || x == 399 || y == 0 || y == 399 {
                    // On the edge of box so will effectively infinite and thus ignored
                    infiniteAreaIndexes.insert(trueMinPointIndex)
                }
            }
        }
        var largestArea = 0
        for i in 0..<points.count {
            if infiniteAreaIndexes.contains(i) {
                continue
            }
            let currentArea = areas[i]
            if largestArea < currentArea {
                largestArea = currentArea
            }
        }
        print("🦆 Day 6 Part 1 Largest Area is: \(largestArea)")
        var isWithinDistanceMatrix:[[Bool]] = Array(repeating: Array(repeating: true, count: 400), count: 400)
        var count = 160000
        for x in 0..<400 {
            for y in 0..<400 {
                var totalDistance = 0
                for point in points {
                    totalDistance += Day6.manhattanDistance(from: Point(x:x, y:y), to: point)
                    if totalDistance >= 10000 {
                        isWithinDistanceMatrix[x][y] = false
                        count -= 1
                        break
                    }
                }
            }
        }
        print("🦆 Day 6 Part 2 Largest Region is: \(count)")
        
    }
    
    static private func manhattanDistance(from pointA:Point, to pointB:Point) -> Int {
        let xDistance = abs(pointA.x - pointB.x)
        let yDistance = abs(pointA.y - pointB.y)
        return xDistance + yDistance
    }
    
}
