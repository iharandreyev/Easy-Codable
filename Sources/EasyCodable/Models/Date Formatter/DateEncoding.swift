//
//  File.swift
//  
//
//  Created by Igor on 4.04.21.
//

import Foundation

// MARK: - Encoding Strategy

public protocol DateEncodingStrategyType {
  static func string(from date: Date) -> String
}

// MARK: Auto

public struct AutoDateEncodingStrategy: DateEncodingStrategyType {
  private init() { }
  
  private static let format: DateFormat = .dateTimeTimeZone1
  
  public static func string(from date: Date) -> String {
    let dateFormatter = DateFormatter.shared
    return dateFormatter.string(from: date, format: format)
  }
}

// MARK: - Encodable Date Type

public protocol EncodableDateType {
  func insert<EncodingStrategy: DateEncodingStrategyType>(
    into container: inout SingleValueEncodingContainer,
    with encodingStrategy: EncodingStrategy.Type
  ) throws
}

// MARK: Date

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

extension Optional: EncodableDateType where Wrapped == Date {
  public func insert<EncodingStrategy: DateEncodingStrategyType>(
    into container: inout SingleValueEncodingContainer,
    with encodingStrategy: EncodingStrategy.Type
  ) throws {
    guard case .some(let date) = self else { return }
    try date.insert(into: &container, with: encodingStrategy)
  }
}
