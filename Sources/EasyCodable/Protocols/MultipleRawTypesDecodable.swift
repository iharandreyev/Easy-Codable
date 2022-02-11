//
//  MultipleRawTypesDecodable.swift
//  
//  MIT License
//
//  Copyright (c) 2021 Ihar Andreyeu
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//
//  Created by Ihar Andreyeu on 2/21/21.
//

import Foundation

public protocol MultipleRawTypesDecodable: Decodable {
  associatedtype IntermediateValue
  
  static func createDecodingFunctions(
    for container: SingleValueDecodingContainer,
    userInfo: [CodingUserInfoKey: Any]
  ) -> [() throws -> IntermediateValue]
  
  init(intermediateValue: IntermediateValue) throws
}

// MARK: - Default Implimentation

public extension MultipleRawTypesDecodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    
    var decodingFunctions = Self.createDecodingFunctions(
      for: container,
      userInfo: decoder.userInfo)
    
    while let decodingFunction = decodingFunctions.removeFirstElement() {
      do {
        try self.init(intermediateValue: decodingFunction())
        return
      } catch DecodingError.typeMismatch {
        guard decodingFunctions.isEmpty else { continue }
      }
    }
    throw DecodingError.dataCorruptedError(
      in: container,
      debugDescription: "Can't decode \(Self.self)")
  }
}
