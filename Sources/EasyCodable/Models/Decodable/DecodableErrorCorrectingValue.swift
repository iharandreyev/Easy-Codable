//
//  DecodableErrorCorrectingValue.swift
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

public typealias DecodableCorrectingValue<
  Value: DecodableRawValueType,
  DefaultValueStrategy: DefaultValueStrategyType
> = DecodableErrorCorrectingValue<
  Value,
  ErrorCorrectionStrategy<DefaultValueStrategy>
> where DefaultValueStrategy.Value == Value

@propertyWrapper
public struct DecodableErrorCorrectingValue<
  Value: DecodableRawValueType,
  ErrorCorrection: ErrorCorrectionStrategyType
>:
  Decodable where ErrorCorrection.Value == Value
{
  public var wrappedValue: Value
  
  public init(wrappedValue: Value) {
    self.wrappedValue = wrappedValue
  }
  
  public init(from decoder: Decoder) throws {
    var container = try decoder.singleValueContainer()
    do {
      wrappedValue = try Value.extract(from: &container)
    } catch {
      wrappedValue = try ErrorCorrection.recover(from: error)
    }
  }
}

// MARK: - Optional

public extension KeyedDecodingContainer {
  func decode<V: ExpressibleByNilLiteral, ErrorCorrection>(
    _ type: DecodableErrorCorrectingValue<V, ErrorCorrection>.Type,
    forKey key: K
  ) throws -> DecodableErrorCorrectingValue<V, ErrorCorrection> {
    guard let value = try decodeIfPresent(type, forKey: key) else {
      return DecodableErrorCorrectingValue(wrappedValue: nil)
    }
    return value
  }
}
