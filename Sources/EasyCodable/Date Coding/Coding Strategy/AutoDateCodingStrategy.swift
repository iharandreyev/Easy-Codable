//
//  File.swift
//  
//
//  Created by Igor on 4.04.21.
//

import Foundation

public struct AutoDateCodingStrategy: DateCodingStrategyType {
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
  
  public static func string(from date: Date) -> String {
    let dateFormatter = DateFormatter.shared
    return dateFormatter.string(from: date, format: formats[0])
  }
}
