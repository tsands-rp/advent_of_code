//
//  Day6.swift
//  AdventOfCode2019
//
//  Created by Trey Sands on 12/5/19.
//  Copyright © 2019 Trey Sands. All rights reserved.
//

import Foundation
class Day6 {
    var input: [[String]] = [[]]
    func main() {
        let inputArray = Parser.arrayOfArrayOfStrings(from: "day_6", with: #"(...)\)(...)"#, numberOfCaptures: 2)
        self.input = inputArray
        var treeDict:[String:Orbiter] = [:]
        for orbit in self.input {
            let parentID = orbit[0]
            let childID = orbit[1]
            let parentOrbiter: Orbiter
            let childOrbiter: Orbiter
            if let parent = treeDict[parentID] {
                parentOrbiter = parent
            } else {
                parentOrbiter = Orbiter(id: parentID)
            }
            if let child = treeDict[childID] {
                childOrbiter = child
            } else {
                childOrbiter = Orbiter(id: childID)
            }
            parentOrbiter.add(child: childOrbiter)
            treeDict[parentID] = parentOrbiter
            treeDict[childID] = childOrbiter
        }
        self.part1(tree: treeDict)
        self.part2(tree: treeDict)
    }
    
    private func part1(tree: [String:Orbiter]) {
        print("💅 Day 6 Part 1 Total Links: \(tree["COM"]!.links(input: 0))")
    }
    
    private func part2(tree: [String:Orbiter]) {
        var youTree:[String: Int] = [:]
        var sanTree:[String: Int] = [:]
        var currentOrbiter = tree["YOU"]!
        var level = -1
        while currentOrbiter.parent != nil {
            level += 1
            currentOrbiter = currentOrbiter.parent!
            let parentID = currentOrbiter.id
            youTree[parentID] = level
        }
        
        currentOrbiter = tree["SAN"]!
        level = -1
        while currentOrbiter.parent != nil {
            level += 1
            currentOrbiter = currentOrbiter.parent!
            let parentID = currentOrbiter.id
            sanTree[parentID] = level
        }
        
        var minLinkages = 10000000000
        for key in youTree.keys {
            guard let sanValue = sanTree[key] else { continue }
            let youValue = youTree[key]!
            let totalDistance = sanValue + youValue
            if totalDistance < minLinkages {
                minLinkages = totalDistance
            }
        }
        print("💅 Day 6 Part 2 Minimum Change: \(minLinkages)")
    }
}


class Orbiter {
    let id: String
    weak var parent: Orbiter? = nil
    var children: [Orbiter] = []
    
    init(id: String) {
        self.id = id
    }
    func count() -> Int {
        var count = 1 // for self
        for child in self.children {
            count += child.count()
        }
        return count
    }
    
    func links(input: Int) -> Int {
        var total = input
        for child in self.children {
            total += child.links(input: input+1)
        }
        return total
    }
    
    func add(child: Orbiter) {
      children.append(child)
      child.parent = self
    }
}

