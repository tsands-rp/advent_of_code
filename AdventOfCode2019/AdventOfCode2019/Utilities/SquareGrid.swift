//
//  SquareGrid.swift
//  AdventOfCode2019
//
//  Created by Trey Sands on 12/3/19.
//  Copyright © 2019 Trey Sands. All rights reserved.
//

import Foundation
class SquareGrid<T> {
    private var grid: [Point:T] = [:]
    private let origin: Point
    private(set) var currentPoint: Point
    private let startingPoint: Point
    
    init(origin: Point, startingPoint: Point) {
        self.origin = origin
        self.startingPoint = startingPoint
        self.currentPoint = startingPoint
    }
    
    func moveOne(inDirection direction: String) {
        switch direction {
        case "R":
            self.currentPoint.x += 1
        case "L":
            self.currentPoint.x -= 1
        case "U":
            self.currentPoint.y += 1
        case "D":
            self.currentPoint.y -= 1
        default:
            break
        }
    }
    
    func valueAtCurrentPoint() -> T? {
        return self.grid[self.currentPoint]
    }
    
    func setValueAtCurrentPoint(_ value: T) {
        self.grid[self.currentPoint] = value
    }
    
    func resetToStartingPoint() {
        self.currentPoint = self.startingPoint
    }
    
    func manhattanDistanceToOrigin(from point:Point) -> Int {
        return abs(self.origin.x - point.x) + abs(self.origin.y - point.y)
    }
}
