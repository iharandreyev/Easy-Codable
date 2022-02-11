//
//  File.swift
//  
//
//  Created by Igor on 4.04.21.
//

import UIKit

// MARK: - Keyed

public extension KeyedDecodingContainer {
  func decode(
    _ type: UIColor.Type,
    forKey key: K
  ) throws -> UIColor {
    try decode(ColorValue.self, forKey: key).color
  }
  
  func decodeIfPresent(
    _ type: UIColor.Type,
    forKey key: K
  ) throws -> UIColor? {
    try decodeIfPresent(ColorValue.self, forKey: key)?.color
  }
  
  func decode(
    _ type: UIColor.Type,
    forKey key: K,
    defaultValue: UIColor
  ) throws -> UIColor {
    try decodeIfPresent(UIColor.self, forKey: key) ?? defaultValue
  }
}

// MARK: - Unkeyed

public extension SingleValueDecodingContainer {
  func decode(_ type: UIColor.Type) throws -> UIColor {
    try decode(ColorValue.self).color
  }
  
  func decodeIfPresent(_ type: UIColor.Type) throws -> UIColor? {
    try decodeIfPresent(ColorValue.self)?.color
  }
  
  func decodeColor(defaultValue: UIColor) throws -> UIColor {
  
  }
  
  
}
