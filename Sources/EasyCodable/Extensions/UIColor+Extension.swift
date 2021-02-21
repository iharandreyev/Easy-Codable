//
//  UIColor+Extension.swift
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

// MARK: - RGBA

public extension UIColor {
  convenience init(_ red: Int, _ green: Int, _ blue: Int, _ alpha: CGFloat = 1) throws {
    try self.init(rgba: RGBA(red: red, green: green, blue: blue, alpha: alpha))
  }

  convenience init(rgba: RGBA) {
    self.init(
      red: CGFloat(rgba.red) / 255,
      green: CGFloat(rgba.green) / 255,
      blue: CGFloat(rgba.blue) / 255,
      alpha: rgba.alpha)
  }

  convenience init(hexString: String) throws {
    try self.init(rgba: RGBA(hexString: hexString))
  }

  var rgba: RGBA {
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    getRed(&red, green: &green, blue: &blue, alpha: &alpha)

    return try! RGBA(red: red, green: green, blue: blue, alpha: alpha)
  }
}

// MARK: - CodableRawValueType

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
