//
//  Day8.swift
//  Advent Of Code 2018
//
//  Created by Trey Sands on 11/12/19.
//  Copyright © 2019 Trey Sands. All rights reserved.
//

import Foundation
class Day8 {
    static func main() {
        var licenseFile:[Int] = []
        for char in day_8_input.split(separator: " ") {
            licenseFile.append(Int(String(char))!)
        }
        let topNode = Node(array: licenseFile)
        print("👾 Day 8 Part 1 Sum of Metadata is: \(topNode.valueOfAllMetadata())")
        print("👾 Day 8 Part 1 Value of TopNode is: \(topNode.value())")
    }
    
//    static private func makeNode(using array:[Int]) -> Node {
//        var returnNode = Node()
//        var numberOfChildrenLeft = array[0]
//        var numberOfMetadata = array[1]
//        var currentSpotInArray = 2
//        for _ in 0..<numberOfChildrenLeft {
//            let child = Day8.makeNode(using: Array(array[currentSpotInArray...]))
//            returnNode.children.append(child)
//            currentSpotInArray += child.size()
//        }
//        for i in 0..<numberOfMetadata {
//            returnNode.metadata.append(array[currentSpotInArray + i + 1])
//        }
//        return returnNode
//    }
}

private class Node {
    var children:[Node] = []
    var metadata:[Int] = []
    
    init(array:[Int]) {
        let numberOfChildren = array[0]
        let numberOfMetaData = array[1]
        var currentSpotInArray = 2
        for _ in 0..<numberOfChildren {
            let childNode = Node(array: Array(array[currentSpotInArray...]))
            self.children.append(childNode)
            currentSpotInArray += childNode.size()
        }
        for i in 0..<numberOfMetaData {
            self.metadata.append(array[currentSpotInArray + i])
        }
    }
    
    func size() -> Int {
        var childrenSize = 2
        for child in self.children {
            childrenSize += child.size()
        }
        return childrenSize + metadata.count
    }
    
    func valueOfAllMetadata() -> Int {
        var returnValue = 0
        for child in self.children {
            returnValue += child.valueOfAllMetadata()
        }
        return returnValue + metadata.reduce(0, +)
    }
    
    func value() -> Int {
        if self.children.count == 0 {
            return metadata.reduce(0, +)
        }
        var returnValue = 0
        for index in self.metadata {
            guard 0 < index, index < self.children.count+1 else { continue }
            let child = self.children[index-1]
            returnValue += child.value()
        }
        return returnValue
    }
}
