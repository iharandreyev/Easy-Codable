//
//  File.swift
//  
//
//  Created by Igor on 3.04.21.
//

import Foundation

public struct DateFormat: ExpressibleByStringRawRepresentable {
  public let rawValue: String
  
  public init(rawValue: String) {
    self.rawValue = rawValue
  }
}

// MARK: - Factory

#warning("TODO: - Add descriptions")
public extension DateFormat {
  /// yyyy-MM-dd'T'HH:mm:ssZ
  static let dateTimeTimeZone1: Self = "yyyy-MM-dd'T'HH:mm:ssZ"
  /// yyyy-MM-dd'T'HH:mm:ssZZZZZ
  static let dateTimeTimeZone2: Self = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
  /// dd/MMM/yyyy'T'HH:mm:ssZ
  static let dateTimeTimeZone3: Self = "dd/MMM/yyyy'T'HH:mm:ssZ"
  /// dd/MMM/yyyy'T'HH:mm:ssZZZZZ
  static let dateTimeTimeZone4: Self = "dd/MMM/yyyy'T'HH:mm:ssZZZZZ"
  static let dateTimeTimeZone5: Self = "dd/MM/yyyy'T'HH:mm:ssZ"
  static let dateTimeTimeZone6: Self = "dd/MM/yyyy'T'HH:mm:ssZZZZZ"
  static let dateTimeTimeZone7: Self = "dd.MM.yyyy'T'HH:mm:ssZ"
  static let dateTimeTimeZone8: Self = "dd.MM.yyyy'T'HH:mm:ssZZZZZ"
  
  static let dateTime1: Self = "yyyy-MM-dd HH:mm:ss"
  static let dateTime2: Self = "dd/MMM/yyyy HH:mm:ss"
  static let dateTime3: Self = "dd/MM/yyyy HH:mm:ss"
  static let dateTime4: Self = "dd.MM.yyyy HH:mm:ss"
  
  static let dateTimeShort1: Self = "yyyy-MM-dd HH:mm"
  static let dateTimeShort2: Self = "dd/MMM/yyyy HH:mm"
  static let dateTimeShort3: Self = "dd/MM/yyyy HH:mm"
  static let dateTimeShort4: Self = "dd.MM.yyyy HH:mm"
  
  static let timeDate1: Self = "HH:mm:ss yyyy-MM-dd"
  static let timeDate2: Self = "HH:mm:ss dd/MMM/yyyy"
  static let timeDate3: Self = "HH:mm:ss dd/MM/yyyy"
  static let timeDate4: Self = "HH:mm:ss dd.MM.yyyy"
  
  static let timeShortDate1: Self = "HH:mm yyyy-MM-dd"
  static let timeShortDate2: Self = "HH:mm dd/MMM/yyyy"
  static let timeShortDate3: Self = "HH:mm dd/MM/yyyy"
  static let timeShortDate4: Self = "HH:mm dd.MM.yyyy"
  
  static let timeShortDateShort1: Self = "HH:mm MM-dd"
  static let timeShortDateShort2: Self = "HH:mm dd/MMM"
  static let timeShortDateShort3: Self = "HH:mm dd/MM"
  static let timeShortDateShort4: Self = "HH:mm dd.MM"
  
  static let date1: Self = "yyyy-MM-dd"
  static let date2: Self = "dd/MMM/yyyy"
  static let date3: Self = "dd/MM/yyyy"
  static let date4: Self = "dd.MM.yyyy"
  
  static let dateShort1: Self = "MM-dd"
  static let dateShort2: Self = "dd/MMM"
  static let dateShort3: Self = "dd/MM"
  static let dateShort4: Self = "dd.MM"
  
  static let time: Self = "HH:mm:ss"
  static let timeShort: Self = "HH:mm:ss"
}
