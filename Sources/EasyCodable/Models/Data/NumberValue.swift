//
//  NumberValue.swift
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

public struct NumberValue {
  public let value: NSNumber
  
  public init(value: NSNumber) {
    self.value = value
  }
}

// MARK: - Decodable

extension NumberValue: MultipleRawTypesDecodable {
  public typealias IntermediateValue = NSNumber
  
  public static func createDecodingFunctions(
    for container: SingleValueDecodingContainer,
    userInfo: [CodingUserInfoKey: Any]
  ) -> [() throws -> IntermediateValue] {
    return [
      { try container.decodeNumber(ofType: .double) },
      { try container.decodeNumber(ofType: .bool) },
      { try container.decodeNumber(ofType: .string, using: userInfo.value(forKey: .numberFormatter)) }
    ]
  }
  
  public init(intermediateValue: IntermediateValue) throws {
    self.init(value: intermediateValue)
  }
}

// MARK: - Encodable

extension NumberValue: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(value.doubleValue)
  }
}

// MARK: - ExpressibleByLiteral

extension NumberValue: ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral {
  public init(floatLiteral value: Float) {
    self.value = NSNumber(value: value)
  }
  
  public init(integerLiteral value: Int) {
    self.value = NSNumber(value: value)
  }
}

// MARK: - ExpressibleByStringValue

extension NumberValue: ExpressibleByStringValue {
  public init?(_ string: String) {
    self.init(string, formatter: .shared)
  }
  
  public init?(_ string: String, formatter: NumberFormatter) {
    guard let value = formatter.number(from: string) else { return nil }
    self.value = value
  }
  
  public func asString() -> String { "\(value)" }
}

// MARK: - Zeroable

extension NumberValue: Zeroable {
  public static var zero: NumberValue { 0 }
}
