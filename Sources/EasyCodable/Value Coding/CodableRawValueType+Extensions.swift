//
//  CodableRawValueType+Extensions.swift
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

// MARK: - Optional<Wrapped: DecodableRawValueType>

extension Optional: DecodableRawValueType where Wrapped: DecodableRawValueType {
  public static func extract(
    from container: inout SingleValueDecodingContainer
  ) throws -> Self {
    do {
      return try Wrapped.extract(from: &container)
    } catch DecodingError.valueNotFound {
      return nil
    }
  }
}

extension Optional: EncodableRawValueType where Wrapped: EncodableRawValueType {
  public func insert(into container: inout SingleValueEncodingContainer) throws {
    guard case .some(let wrapped) = self else { return }
    try wrapped.insert(into: &container)
  }
}

// MARK: - String

extension String: CodableRawValueType {
  public static func extract(
    from container: inout SingleValueDecodingContainer
  ) throws -> Self {
    try container.decodeString()
  }
}

// MARK: - UIColor

import UIKit

extension UIColor: CodableRawValueType {
  public static func extract(
    from container: inout SingleValueDecodingContainer
  ) throws -> Self {
    try container.decodeColor() as! Self
  }
  
  public func insert(into container: inout SingleValueEncodingContainer) throws {
    try container.encode(rgba.shortHexString)
  }
}
