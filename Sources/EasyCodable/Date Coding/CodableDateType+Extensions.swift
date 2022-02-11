//
//  File.swift
//  
//
//  Created by Igor on 4.04.21.
//

import Foundation

// MARK: Date

extension Date: DecodableDateType {
  public static func extract<DecodingStrategy: DateDecodingStrategyType>(
    from container: inout SingleValueDecodingContainer,
    with decodingStrategy: DecodingStrategy.Type
  ) throws -> Self {
    let string = try container.decode(String.self)
    return try decodingStrategy.date(from: string)
  }
}

extension Date: EncodableDateType {
  public func insert<EncodingStrategy: DateEncodingStrategyType>(
    into container: inout SingleValueEncodingContainer,
    with encodingStrategy: EncodingStrategy.Type
  ) throws {
    let string = encodingStrategy.string(from: self)
    try container.encode(string)
  }
}

// MARK: Optional<Date>

extension Optional: DecodableDateType where Wrapped == Date {
  public static func extract<DecodingStrategy: DateDecodingStrategyType>(
    from container: inout SingleValueDecodingContainer,
    with decodingStrategy: DecodingStrategy.Type
  ) throws -> Self {
    do {
      return try Date.extract(from: &container, with: decodingStrategy)
    } catch DecodingError.valueNotFound {
      return nil
    }
  }
}

extension Optional: EncodableDateType where Wrapped == Date {
  public func insert<EncodingStrategy: DateEncodingStrategyType>(
    into container: inout SingleValueEncodingContainer,
    with encodingStrategy: EncodingStrategy.Type
  ) throws {
    guard case .some(let date) = self else { return }
    try date.insert(into: &container, with: encodingStrategy)
  }
}
