//
//  File.swift
//  
//
//  Created by Igor on 4.04.21.
//

import Foundation

public struct DateFormattingSettings {
  public let behavior: DateFormatter.Behavior
  public let dateStyle: DateFormatter.Style
  public let timeStyle: DateFormatter.Style
  public let locale: Locale?
  public let timeZone: TimeZone?
  
  public init(
    behavior: DateFormatter.Behavior = .behavior10_4,
    dateStyle: DateFormatter.Style = .full,
    timeStyle: DateFormatter.Style = .full,
    locale: Locale? = nil,
    timeZone: TimeZone? = nil
  ) {
    self.behavior = behavior
    self.dateStyle = dateStyle
    self.timeStyle = timeStyle
    self.locale = locale
    self.timeZone = timeZone
  }
}
