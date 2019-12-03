//
//  Parser.swift
//  Advent Of Code 2018
//
//  Created by Trey Sands on 11/7/19.
//  Copyright © 2019 Trey Sands. All rights reserved.
//

import Foundation

class Parser {
    static func arrayOfStrings(from textFile:String) -> [String] {
        let path = Bundle.main.path(forResource: textFile, ofType: "txt")!
        do {
            let data = try String(contentsOfFile: path, encoding: .utf8)
            return data.components(separatedBy: "\n")
        } catch {
            return []
        }
    }
    
    static func arrayOfArrayOfStrings(from textFile:String, with pattern:String, numberOfCaptures:Int) -> [[String]] {
        do {
            var returnArray:[[String]] = []
            let inputArray = Parser.arrayOfStrings(from: textFile)
            for inputString in inputArray {
                let regex = try NSRegularExpression(pattern: pattern, options: [])
                let range = NSRange(inputString.startIndex..<inputString.endIndex, in: inputString)
                
                regex.enumerateMatches(in: inputString, options: [], range: range) { match, _, stop in
                    guard let match = match else { return }
                    var tempReturnStringArray:[String] = []
                    for i in 1...numberOfCaptures {
                        guard let range = Range(match.range(at: i), in: inputString) else {
                                continue
                        }
                        tempReturnStringArray.append(String(inputString[range]))
                    }
                    returnArray.append(tempReturnStringArray)
                }
            }
            return returnArray
        } catch {
            return [[]]
        }
    }
}
