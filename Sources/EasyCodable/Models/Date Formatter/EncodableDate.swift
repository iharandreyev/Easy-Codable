//
//  File.swift
//  
//
//  Created by Igor on 4.04.21.
//

import Foundation

typealias AutoEncodableDate<Value: EncodableDateType> = EncodableDate<Value, AutoDateEncodingStrategy>

@propertyWrapper
public struct EncodableDate<
  Value: EncodableDateType,
  EncodingStrategy: DateEncodingStrategyType
>: Encodable {
  public var wrappedValue: Value
  
  public init(wrappedValue: Value) {
    self.wrappedValue = wrappedValue
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try wrappedValue.insert(into: &container, with: EncodingStrategy.self)
  }
}

