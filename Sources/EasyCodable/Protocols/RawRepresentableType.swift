//
//  File.swift
//  
//
//  Created by Igor on 4.04.21.
//

import Foundation

public protocol ExpressibleByStringRawRepresentable:
  ExpressibleByStringLiteral,
  Hashable
{
  associatedtype RawValue: Hashable
  var rawValue: RawValue { get }
  
  init(rawValue: RawValue)
}

public extension ExpressibleByStringRawRepresentable {
  init(stringLiteral: RawValue) {
    self.init(rawValue: stringLiteral)
  }
}
