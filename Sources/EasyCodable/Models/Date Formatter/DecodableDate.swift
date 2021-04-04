//
//  File.swift
//  
//
//  Created by Igor on 4.04.21.
//

import Foundation

typealias AutoDecodableDate<Value: DecodableDateType> = DecodableDate<Value, AutoDateDecodingStrategy>

@propertyWrapper
public struct DecodableDate<
  Value: DecodableDateType,
  DecodingStrategy: DateDecodingStrategyType
>: Decodable {
  public var wrappedValue: Value
  
  public init(wrappedValue: Value) {
    self.wrappedValue = wrappedValue
  }
  
  public init(from decoder: Decoder) throws {
    var container = try decoder.singleValueContainer()
    wrappedValue = try Value.extract(
      from: &container,
      with: DecodingStrategy.self)
  }
}

// MARK: - Optional

public extension KeyedDecodingContainer {
  func decode<
    V: ExpressibleByNilLiteral,
    DecodingStrategy: DateDecodingStrategyType
  >(
    _ type: DecodableDate<V, DecodingStrategy>.Type,
    forKey key: K
  ) throws -> DecodableDate<V, DecodingStrategy> {
    guard let value = try decodeIfPresent(type, forKey: key) else {
      return DecodableDate<V, DecodingStrategy>(wrappedValue: nil)
    }
    return value
  }
}
