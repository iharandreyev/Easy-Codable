//
//  File.swift
//  
//
//  Created by Igor on 4.04.21.
//

import Foundation

// MARK: - Decoding Strategy

public protocol DateDecodingStrategyType {
  static func date(from string: String) throws -> Date
}

// MARK: Auto

public struct AutoDateDecodingStrategy: DateDecodingStrategyType {
  private init() { }
  
  private static let formats: [DateFormat] = [
    .dateTimeTimeZone1,
    .dateTimeTimeZone2,
    .dateTimeTimeZone3,
    .dateTimeTimeZone4,
    .dateTimeTimeZone5,
    .dateTimeTimeZone6,
    .dateTimeTimeZone7,
    .dateTimeTimeZone8,
    .dateTime1,
    .dateTime2,
    .dateTime3,
    .dateTime4,
    .dateTimeShort1,
    .dateTimeShort2,
    .dateTimeShort3,
    .dateTimeShort4,
    .timeDate1,
    .timeDate2,
    .timeDate3,
    .timeDate4,
    .timeShortDate1,
    .timeShortDate2,
    .timeShortDate3,
    .timeShortDate4,
    .date1,
    .date2,
    .date3,
    .date4
  ]
  
  public static func date(from string: String) throws -> Date {
    let dateFormatter = DateFormatter.shared
    for format in formats {
      do {
        return try dateFormatter.date(from: string, format: format)
      } catch {
        continue
      }
    }
    throw DateFormatter.Error.invalidInput(string)
  }
}

// MARK: - Decodable Date Type

public protocol DecodableDateType {
  static func extract<DecodingStrategy: DateDecodingStrategyType>(
    from container: inout SingleValueDecodingContainer,
    with decodingStrategy: DecodingStrategy.Type
  ) throws -> Self
}

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
