//
//  File.swift
//  
//
//  Created by Igor on 4.04.21.
//

import Foundation

// MARK: - DateCodingStrategyType

public typealias DateCodingStrategyType = DateDecodingStrategyType & DateEncodingStrategyType

// MARK: Auto

public struct AutoDateCodingStrategy: DateCodingStrategyType {
  private init() { }

  public static func date(from string: String) throws -> Date {
    try AutoDateDecodingStrategy.date(from: string)
  }
  
  public static func string(from date: Date) -> String {
    AutoDateEncodingStrategy.string(from: date)
  }
}

// MARK: - CodableDateType

public typealias CodableDateType = DecodableDateType & EncodableDateType
