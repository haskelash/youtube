//
//  String+Substring.swift
//  Youtube
//
//  Created by Haskel Ash on 2/3/22.
//

import Foundation

extension StringProtocol {
  func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
    range(of: string, options: options)?.lowerBound
  }

  func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
    range(of: string, options: options)?.upperBound
  }

  func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
    ranges(of: string, options: options).map(\.lowerBound)
  }

  func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
    var results: [Range<Index>] = []
    var startIndex = self.startIndex
    while startIndex < endIndex, let range = self[startIndex...].range(of: string, options: options) {
      results.append(range)
      startIndex = range.lowerBound < range.upperBound ?
        range.upperBound : index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
    }
    return results
  }
}
