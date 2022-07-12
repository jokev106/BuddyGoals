//
//  StringExtension.swift
//  BuddyGoals
//
//  Created by Terrence Pramono on 24/06/22.
//

import Foundation

// String Extension for slicing like array : String[1..<String.count]
extension String {
    subscript (index: Int) -> Character {
        let charIndex = self.index(self.startIndex, offsetBy: index)
        return self[charIndex]
    }

    subscript (range: Range<Int>) -> Substring {
        let startIndex = self.index(self.startIndex, offsetBy: range.startIndex)
        let stopIndex = self.index(self.startIndex, offsetBy: range.startIndex + range.count)
        return self[startIndex..<stopIndex]
    }
}
