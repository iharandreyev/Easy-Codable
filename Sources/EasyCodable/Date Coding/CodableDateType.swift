//
//  File.swift
//  
//
//  Created by Igor on 4.04.21.
//

import Foundation

public protocol DecodableDateType {
  static func extract<DecodingStrategy: DateDecodingStrategyType>(
    from container: inout SingleValueDecodingContainer,
    with decodingStrategy: DecodingStrategy.Type
  ) throws -> Self
}

public protocol EncodableDateType {
  func insert<EncodingStrategy: DateEncodingStrategyType>(
    into container: inout SingleValueEncodingContainer,
    with encodingStrategy: EncodingStrategy.Type
  ) throws
}

public typealias CodableDateType = DecodableDateType & EncodableDateType
