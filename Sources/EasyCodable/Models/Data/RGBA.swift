//
//  RGBA.swift
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

public struct RGBA {
  let red: Int
  let green: Int
  let blue: Int
  let alpha: CGFloat

  public init(
    red: CGFloat,
    green: CGFloat,
    blue: CGFloat,
    alpha: CGFloat = 1
  ) throws {
    try self.init(
      red: red.asColorComponent(),
      green: green.asColorComponent(),
      blue: blue.asColorComponent(),
      alpha: alpha)
  }

  public init(
    red: Int,
    green: Int,
    blue: Int,
    alpha: CGFloat = 1
  ) throws {
    try Self.validateComponents(red: red, green: green, blue: blue, alpha: alpha)
    self.red = red
    self.green = green
    self.blue = blue
    self.alpha = alpha
  }

  public init(hexString: String) throws {
    var hexString = hexString
      .trimmingCharacters(in: .whitespacesAndNewlines)
      .uppercased()

    if hexString.hasPrefix("#") {
      hexString.remove(at: hexString.startIndex)
    }
    guard (hexString.count) == 6 else { throw RGBA.Error.invalidHex(hexString) }

    var rgbValue: UInt64 = 0
    Scanner(string: hexString).scanHexInt64(&rgbValue)
    try self.init(
      red: Int((rgbValue & 0xFF0000) >> 16),
      green: Int((rgbValue & 0x00FF00) >> 8),
      blue: Int(rgbValue & 0x0000FF))
  }

  private static func validateComponents(
    red: Int,
    green: Int,
    blue: Int,
    alpha: CGFloat
  ) throws {
    var invalidComponents: [RGBA.Component: Any] = [:]
    if !red.isValidColorComponent() {
      invalidComponents[.red] = red
    }
    if !green.isValidColorComponent() {
      invalidComponents[.green] = green
    }
    if !blue.isValidColorComponent() {
      invalidComponents[.blue] = blue
    }
    if !alpha.isValidColorComponent() {
      invalidComponents[.alpha] = alpha
    }
    guard invalidComponents.isEmpty else {
      throw RGBA.Error.invalidComponents(invalidComponents)
    }
  }

  public var shortHexString: String {
    "\(red.hexValue()))\(green.hexValue())\(blue.hexValue())"
  }

  public var longHexString: String {
    "\(red.hexValue()))\(green.hexValue())\(blue.hexValue())\(alpha.asColorComponent())"
  }
}

// MARK: - CustomStringConvertible

extension RGBA: CustomStringConvertible {
  public var description: String {
    "r: \(red), g: \(green), b: \(blue). a: \(alpha)"
  }
}

// MARK: - Component

public extension RGBA {
  enum Component {
    case red
    case green
    case blue
    case alpha
  }
}

// MARK: - Error

public extension RGBA {
  enum Error: Swift.Error {
    case invalidComponents([Component: Any])
    case invalidHex(String)
  }
}

// MARK: - Int + Convenience

private extension Int {
  func isValidColorComponent() -> Bool {
    self >= 0 && self <= 255
  }
}

// MARK: - CGFloat + Convenience

private extension CGFloat {
  func asColorComponent() -> Int {
    guard self >= 0, self <= 1 else { return 0 }
    return Int((self * 255).rounded())
  }

  func isValidColorComponent() -> Bool {
    self >= 0 && self <= 1
  }
}

