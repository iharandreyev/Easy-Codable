//
//  File.swift
//  
//
//  Created by Igor on 4.04.21.
//

import Foundation

public extension DateFormatter {
  enum Error: Swift.Error {
    case invalidInput(String)
  }
  
  static var shared = DateFormatter()
  
  // MARK: - Style
  
  private func update(with style: DateFormattingStyle) {
    switch style {
      case .format(let format):
        update(with: format)
      case .settings(let settings):
        update(with: settings)
    }
  }
  
  private func update(with format: DateFormat) {
    dateFormat = format.rawValue
  }
  
  private func update(with settings: DateFormattingSettings) {
    formatterBehavior = settings.behavior
    dateStyle = settings.dateStyle
    timeStyle = settings.timeStyle
    locale = settings.locale
    timeZone = settings.timeZone
  }
  
  // MARK: - Date from String
  
  func date(from string: String) throws -> Date {
    guard let date = self.date(from: string) else {
      throw Error.invalidInput(string)
    }
    return date
  }
  
  func date(
    from string: String,
    format: DateFormat
  ) throws -> Date {
    update(with: format)
    return try date(from: string)
  }
  
  // MARK: - String from Date
  
  func string(
    from date: Date,
    format: DateFormat
  ) -> String {
    update(with: format)
    return string(from: date)
  }
  
  func string(
    from date: Date,
    settings: DateFormattingSettings
  ) -> String {
    update(with: settings)
    return string(from: date)
  }
  
  func string(
    from date: Date,
    style: DateFormattingStyle
  ) -> String {
    update(with: style)
    return string(from: date)
  }
}
