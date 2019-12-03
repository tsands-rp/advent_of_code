//
//  Day3.swift
//  AdventOfCode2019
//
//  Created by Trey Sands on 12/2/19.
//  Copyright © 2019 Trey Sands. All rights reserved.
//

import Foundation
class Day3 {
    func main() {
        let pattern = #"(\D)(\d+)"#
        let wire1 = Parser.arrayOfArrayOfStrings(from: "day_3_a", with: pattern, numberOfCaptures: 2)
        let wire2 = Parser.arrayOfArrayOfStrings(from: "day_3_b", with: pattern, numberOfCaptures: 2)
        self.part1(wire1: wire1, wire2: wire2)
        self.part2(wire1: wire1, wire2: wire2)
    }
    
    func part1(wire1: [[String]], wire2:[[String]]) {
        let hasBeenCrossedYet:SquareGrid<Bool> = SquareGrid<Bool>(origin: Point(x: 50000, y: 50000), startingPoint: Point(x: 50000, y: 50000))
        for velocity in wire1 {
            let direction = velocity[0]
            let magnitude = Int(velocity[1])!
            for _ in 1...magnitude {
                hasBeenCrossedYet.moveOne(inDirection: direction)
                hasBeenCrossedYet.setValueAtCurrentPoint(true)
            }
        }
        hasBeenCrossedYet.resetToStartingPoint()
        var closestDistance = 100000000000000000
        for velocity in wire2 {
            let direction = velocity[0]
            let magnitude = Int(velocity[1])!
            for _ in 1...magnitude {
                hasBeenCrossedYet.moveOne(inDirection: direction)
                if let hasCrossed = hasBeenCrossedYet.valueAtCurrentPoint(), hasCrossed {
                    let distance = hasBeenCrossedYet.manhattanDistanceToOrigin(from: hasBeenCrossedYet.currentPoint)
                    if distance < closestDistance {
                        closestDistance = distance
                    }
                }
            }
        }
        print("⏰ Day 3 Part 1: Closest Distance: \(closestDistance)")
    }
    
    func part2(wire1: [[String]], wire2:[[String]]) {
        let numberOfSteps:SquareGrid<Int> = SquareGrid<Int>(origin: Point(x: 50000, y: 50000), startingPoint: Point(x: 50000, y: 50000))
        var stepsTraveled = 0
        for velocity in wire1 {
            let direction = velocity[0]
            let magnitude = Int(velocity[1])!
            for _ in 1...magnitude {
                stepsTraveled += 1
                numberOfSteps.moveOne(inDirection: direction)
                guard numberOfSteps.valueAtCurrentPoint() == nil else { continue }
                numberOfSteps.setValueAtCurrentPoint(stepsTraveled)
            }
        }
        var shortestDistance = 100000000000000000
        numberOfSteps.resetToStartingPoint()
        stepsTraveled = 0
        for velocity in wire2 {
            let direction = velocity[0]
            let magnitude = Int(velocity[1])!
            for _ in 1...magnitude {
                stepsTraveled += 1
                if shortestDistance < stepsTraveled {
                    break
                }
                numberOfSteps.moveOne(inDirection: direction)
                
                guard let oldSteps = numberOfSteps.valueAtCurrentPoint(), oldSteps > 0 else { continue }
                let totalDistance = oldSteps + stepsTraveled
                if shortestDistance > totalDistance {
                    shortestDistance = totalDistance
                }
            }
        }
        print("⏰ Day 3 Part 2: Shortest Distance: \(shortestDistance)")
    }
}
