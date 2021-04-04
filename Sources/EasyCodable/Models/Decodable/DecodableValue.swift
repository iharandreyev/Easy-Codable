//
//  CodableValue.swift
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
//  Created by Ihar Andreyeu on 4/3/21.
//

import Foundation

@propertyWrapper
public struct DecodableValue<
  Value: DecodableRawValueType
>: Decodable {
  public var wrappedValue: Value
  
  public init(wrappedValue: Value) {
    self.wrappedValue = wrappedValue
  }
  
  public init(from decoder: Decoder) throws {
    var container = try decoder.singleValueContainer()
    wrappedValue = try Value.extract(from: &container)
  }
}

// MARK: - Optional

public extension KeyedDecodingContainer {
  func decode<V: ExpressibleByNilLiteral>(
    _ type: DecodableValue<V>.Type,
    forKey key: K
  ) throws -> DecodableValue<V> {
    guard let value = try decodeIfPresent(type, forKey: key) else {
      return DecodableValue<V>(wrappedValue: nil)
    }
    return value
  }
}
