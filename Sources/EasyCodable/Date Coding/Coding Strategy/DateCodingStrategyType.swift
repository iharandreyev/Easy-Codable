//
//  File.swift
//  
//
//  Created by Igor on 4.04.21.
//

import Foundation

public protocol DateDecodingStrategyType {
  static func date(from string: String) throws -> Date
}

public protocol DateEncodingStrategyType {
  static func string(from date: Date) -> String
}

public typealias DateCodingStrategyType = DateDecodingStrategyType & DateEncodingStrategyType
