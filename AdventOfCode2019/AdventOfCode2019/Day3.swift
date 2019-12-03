//
//  Day3.swift
//  AdventOfCode2019
//
//  Created by Trey Sands on 12/2/19.
//  Copyright © 2019 Trey Sands. All rights reserved.
//

import Foundation
class Day3 {
    var hasBeenCrossedYet:[[Bool]] = Array(repeating: Array(repeating: false, count: 100000), count: 100000)
    var numberOfSteps:[[Int]] = Array(repeating: Array(repeating: 0, count: 100000), count: 100000)
    var currentPoint: (Int, Int) = (50000,50000)
    
    func main() {
        let pattern = #"(\D)(\d+)"#
        let wire1 = Parser.arrayOfArrayOfStrings(from: "day_3_a", with: pattern, numberOfCaptures: 2)
        let wire2 = Parser.arrayOfArrayOfStrings(from: "day_3_b", with: pattern, numberOfCaptures: 2)
        self.part1(wire1: wire1, wire2: wire2)
        self.part2(wire1: wire1, wire2: wire2)
    }
    
    func part1(wire1: [[String]], wire2:[[String]]) {
        for array in wire1 {
            let direction = array[0]
            let magnitude = Int(array[1])!
            switch direction {
            case "R":
                for _ in 1...magnitude {
                    self.currentPoint.0 += 1
                    self.hasBeenCrossedYet[self.currentPoint.0][self.currentPoint.1] = true
                }
            case "L":
                for _ in 1...magnitude {
                    self.currentPoint.0 -= 1
                    self.hasBeenCrossedYet[self.currentPoint.0][self.currentPoint.1] = true
                }
            case "U":
                for _ in 1...magnitude {
                    self.currentPoint.1 += 1
                    self.hasBeenCrossedYet[self.currentPoint.0][self.currentPoint.1] = true
                }
            case "D":
                for _ in 1...magnitude {
                    self.currentPoint.1 -= 1
                    self.hasBeenCrossedYet[self.currentPoint.0][self.currentPoint.1] = true
                }
            default:
                break
            }
        }
        var intersections:[(Int, Int)] = []
        self.currentPoint = (50000, 50000)
        for array in wire2 {
            let direction = array[0]
            let magnitude = Int(array[1])!
            switch direction {
            case "R":
                for _ in 1...magnitude {
                    self.currentPoint.0 += 1
                    if self.hasBeenCrossedYet[self.currentPoint.0][self.currentPoint.1] {
                        intersections.append(self.currentPoint)
                    }
                }
            case "L":
                for _ in 1...magnitude {
                    self.currentPoint.0 -= 1
                    if self.hasBeenCrossedYet[self.currentPoint.0][self.currentPoint.1] {
                        intersections.append(self.currentPoint)
                    }
                }
            case "U":
                for _ in 1...magnitude {
                    self.currentPoint.1 += 1
                    if self.hasBeenCrossedYet[self.currentPoint.0][self.currentPoint.1] {
                        intersections.append(self.currentPoint)
                    }
                }
            case "D":
                for _ in 1...magnitude {
                    self.currentPoint.1 -= 1
                    if self.hasBeenCrossedYet[self.currentPoint.0][self.currentPoint.1] {
                        intersections.append(self.currentPoint)
                    }
                }
            default:
                break
            }
        }
        var maxDistance = 100000000000000000
        for point in intersections {
            let distance = abs(point.0 - 50000) + abs(point.1 - 50000)
            if distance < maxDistance {
                maxDistance = distance
            }
        }
        print("⏰ Day 3 Part 1: Closest Distance: \(maxDistance)")
    }
    
    func part2(wire1: [[String]], wire2:[[String]]) {
        self.currentPoint = (50000, 50000)
        var stepsTraveled = 0
        for array in wire1 {
            let direction = array[0]
            let magnitude = Int(array[1])!
            switch direction {
            case "R":
                for _ in 1...magnitude {
                    self.currentPoint.0 += 1
                    stepsTraveled += 1
                    self.numberOfSteps[self.currentPoint.0][self.currentPoint.1] = stepsTraveled
                }
            case "L":
                for _ in 1...magnitude {
                    self.currentPoint.0 -= 1
                    stepsTraveled += 1
                    self.numberOfSteps[self.currentPoint.0][self.currentPoint.1] = stepsTraveled
                }
            case "U":
                for _ in 1...magnitude {
                    self.currentPoint.1 += 1
                    stepsTraveled += 1
                    self.numberOfSteps[self.currentPoint.0][self.currentPoint.1] = stepsTraveled
                }
            case "D":
                for _ in 1...magnitude {
                    self.currentPoint.1 -= 1
                    stepsTraveled += 1
                    self.numberOfSteps[self.currentPoint.0][self.currentPoint.1] = stepsTraveled
                }
            default:
                break
            }
        }
        var shortestDistance = 100000000000000000
        self.currentPoint = (50000, 50000)
        stepsTraveled = 0
        for array in wire2 {
            let direction = array[0]
            let magnitude = Int(array[1])!
            switch direction {
            case "R":
                for _ in 1...magnitude {
                    self.currentPoint.0 += 1
                    stepsTraveled += 1
                    let oldSteps = self.numberOfSteps[self.currentPoint.0][self.currentPoint.1]
                    if oldSteps > 0 {
                        let totalDistance = oldSteps + stepsTraveled
                        if shortestDistance > totalDistance {
                            shortestDistance = totalDistance
                        }
                    }
                }
            case "L":
                for _ in 1...magnitude {
                    self.currentPoint.0 -= 1
                    stepsTraveled += 1
                    let oldSteps = self.numberOfSteps[self.currentPoint.0][self.currentPoint.1]
                    if oldSteps > 0 {
                        let totalDistance = oldSteps + stepsTraveled
                        if shortestDistance > totalDistance {
                            shortestDistance = totalDistance
                        }
                    }
                }
            case "U":
                for _ in 1...magnitude {
                    self.currentPoint.1 += 1
                    stepsTraveled += 1
                    let oldSteps = self.numberOfSteps[self.currentPoint.0][self.currentPoint.1]
                    if oldSteps > 0 {
                        let totalDistance = oldSteps + stepsTraveled
                        if shortestDistance > totalDistance {
                            shortestDistance = totalDistance
                        }
                    }
                }
            case "D":
                for _ in 1...magnitude {
                    self.currentPoint.1 -= 1
                    stepsTraveled += 1
                    let oldSteps = self.numberOfSteps[self.currentPoint.0][self.currentPoint.1]
                    if oldSteps > 0 {
                        let totalDistance = oldSteps + stepsTraveled
                        if shortestDistance > totalDistance {
                            shortestDistance = totalDistance
                        }
                    }
                }
            default:
                break
            }
        }
        print("⏰ Day 3 Part 2: Shortest Distance: \(shortestDistance)")
    }
}
