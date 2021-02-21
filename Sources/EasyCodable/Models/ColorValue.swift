//
//  ColorValue.swift
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

import UIKit

public struct ColorValue {
  public let color: UIColor
  
  public init(color: UIColor) {
    self.color = color
  }
}

// MARK: - Decodable

extension ColorValue: MultipleRawTypesDecodable {
  public typealias IntermediateValue = String
  
  public static func createDecodingFunctions(
    for container: SingleValueDecodingContainer,
    userInfo: [CodingUserInfoKey: Any]
  ) -> [() throws -> IntermediateValue] {
    return [
      { try container.decode(String.self) },
      { try container.decode(NumberValue.self).value.intValue.hexValue(digits: 6) }
    ]
  }
  
  public init(intermediateValue: IntermediateValue) throws {
    try self.init(color: UIColor(hexString: intermediateValue))
  }
}

// MARK: - Encodable

extension ColorValue: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(color.rgba.shortHexString)
  }
}
