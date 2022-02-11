//
//  File.swift
//  
//
//  Created by Igor on 4.04.21.
//

import Foundation

typealias AutoCodableDate<Value: CodableDateType> = CodableDate<Value, AutoDateCodingStrategy>

@propertyWrapper
public struct CodableDate<
  Value: CodableDateType,
  CodingStrategy: DateCodingStrategyType
>: Codable {
  public var wrappedValue: Value
  
  public init(wrappedValue: Value) {
    self.wrappedValue = wrappedValue
  }
  
  public init(from decoder: Decoder) throws {
    var container = try decoder.singleValueContainer()
    wrappedValue = try Value.extract(
      from: &container,
      with: CodingStrategy.self)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try wrappedValue.insert(into: &container, with: CodingStrategy.self)
  }
}

// MARK: - Optional

public extension KeyedDecodingContainer {
  func decode<
    V: ExpressibleByNilLiteral,
    CodingStrategy: DateCodingStrategyType
  >(
    _ type: CodableDate<V, CodingStrategy>.Type,
    forKey key: K
  ) throws -> CodableDate<V, CodingStrategy> {
    guard let value = try decodeIfPresent(type, forKey: key) else {
      return CodableDate<V, CodingStrategy>(wrappedValue: nil)
    }
    return value
  }
}
