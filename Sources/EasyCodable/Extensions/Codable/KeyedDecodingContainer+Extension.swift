//
//  KeyedDecodingContainer+Extension.swift
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

public extension KeyedDecodingContainer {
  func decode<T: Decodable>(
    _ key: Key,
    as type: T.Type = T.self
  ) throws -> T {
    try decode(type, forKey: key)
  }

  func decode<T: Decodable>(
    _ key: Key,
    as type: T.Type = T.self,
    defaultValue: T
  ) throws -> T {
    try decodeIfPresent(type, forKey: key) ?? defaultValue
  }

  func decodeIfPresent<T: Decodable>(
    _ key: Key,
    as type: T.Type = T.self
  ) throws -> T? {
    try decodeIfPresent(type, forKey: key)
  }
  
  func decode<V>(
    _ type: V.Type,
    forKey key: K
    defaultValue: V
  ) throws -> V {
    do {
      return try decode(type, forKey: key)
    } catch {
      return defaultValue
    }
  }
}

// MARK: - KeyedDecodingContainer + String

public extension KeyedDecodingContainer {
  func decodeString(_ key: Key) throws -> String {
    do {
      return try decode(String.self, forKey: key)
    } catch DecodingError.typeMismatch {
      return try decode(key, as: NumberValue.self).asString()
    }
  }

  func decodeString(_ key: Key, defaultValue: String) throws -> String {
    try decodeStringIfPresent(key) ?? defaultValue
  }

  func decodeStringIfPresent(_ key: Key) throws -> String? {
    do {
      return try decodeString(key)
    } catch DecodingError.valueNotFound {
      return nil
    }
  }
}

// MARK: - UIColor



// MARK: - ExpressibleByStringValue

public extension KeyedDecodingContainer {
  func decode<V: ExpressibleByStringValue>(
    _ type: V.Type,
    forKey key: K
  ) throws -> V {
    do {
      return try decode(type, forKey: key)
    } catch DecodingError.typeMismatch {
      let intermediateValue = try decode(String.self, forKey: key)
      guard let value = T(intermediateValue) else {
        throw DecodingError.transformError(
          forKey: key,
          in: self,
          from: intermediateValue,
          into: T.self)
      }
      return value
    }
  }
  
  func decodeIfPresent<V: ExpressibleByStringValue>(
    _ type: V.Type,
    forKey key: K
  ) throws -> V? {
    do {
      return try decode(type, forKey: k)
    } catch DecodingError.valueNotFound {
      return nil
    }
  }

  func decode<V: ExpressibleByStringValue>(
    _ type: V.Type,
    forKey key: K
    defaultValue: V
  ) throws -> V {
    try decodeIfPresent(type, forKey: key) ?? defaultValue
  }
}
