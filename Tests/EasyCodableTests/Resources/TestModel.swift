//
//  TestModel.swift
//
//  Created by Ihar Andreyeu on 2/21/21.
//

import UIKit
@testable import EasyCodable

struct TestModel: Codable {
  @CodableValue private(set) var color: UIColor
  @CodableValue private(set) var int: Int
  @CodableValue private(set) var string: String
  @CodableValue private(set) var url: URL?
  @CodableValue private(set) var float: Float?
}

extension TestModel: CustomStringConvertible {
  var description: String {
    "color: [\(color.rgba)], int: \(int), string: \(string), url: \(optional: url?.absoluteString), float: \(optional: float)"
  }
}
