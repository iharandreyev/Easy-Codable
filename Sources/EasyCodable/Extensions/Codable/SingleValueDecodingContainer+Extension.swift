//
//  SingleValueDecodingContainer+Extension.swift
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

public extension SingleValueDecodingContainer {
  func decodeIfPresent<V: Decodable>(_ type: V.Type) throws -> V? {
    do {
      return try decode(V.self)
    } catch DecodingError.valueNotFound {
      return nil
    }
  }
  
  func decode<V>(
    _ type: V.Type,
    defaultValue: V
  ) throws -> V {
    do {
      return try decode(type)
    } catch {
      return defaultValue
    }
  }
}

// MARK: - SingleValueDecodingContainer + UIColor

import UIKit



// MARK: - SingleValueDecodingContainer + String

public extension SingleValueDecodingContainer {
  func decodeString() throws -> String {
    do {
      return try decode(String.self)
    } catch DecodingError.typeMismatch {
      return try decode(NumberValue.self).asString()
    }
  }

  func decodeString(defaultValue: String) throws -> String {
    try decodeStringIfPresent() ?? defaultValue
  }

  func decodeStringIfPresent() throws -> String? {
    do {
      return try decodeString()
    } catch DecodingError.valueNotFound {
      return nil
    }
  }
}

// MARK: - SingleValueDecodingContainer + ExpressibleByStringValue

public extension SingleValueDecodingContainer {
  func decode<T: ExpressibleByStringValue & Decodable>(
    as type: T.Type = T.self
  ) throws -> T {
    do {
      return try decode(type)
    } catch DecodingError.typeMismatch {
      let intermediateValue = try decode(String.self)
      guard let value = T(intermediateValue) else {
        throw DecodingError.transformError(in: self, from: intermediateValue, into: T.self)
      }
      return value
    }
  }

  func decode<T: ExpressibleByStringValue & Decodable>(defaultValue: T) throws -> T {
    try decodeIfPresent() ?? defaultValue
  }

  func decodeIfPresent<T: ExpressibleByStringValue & Decodable>() throws -> T? {
    do {
      return try decode()
    } catch DecodingError.valueNotFound {
      return nil
    }
  }
}

// MARK: - SingleValueDecodingContainer + NSNumber

public extension NSNumber {
  enum RawValueType {
    case double
    case bool
    case string
  }
}

public extension SingleValueDecodingContainer {
  func decodeNumber(
    ofType type: NSNumber.RawValueType,
    using formatter: NumberFormatter? = nil
  ) throws -> NSNumber {
    switch type {
      case .double: return try NSNumber(value: decode(Double.self))
      case .bool: return try NSNumber(value: decode(Bool.self))
      case .string: return try (formatter ?? .shared).number(from: decode(String.self))
    }
  }
}
