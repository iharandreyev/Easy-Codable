import XCTest
@testable import EasyCodable

private extension URL {
  static func testsPath() -> URL {
    let thisSourceFile = URL(fileURLWithPath: #file)
    return thisSourceFile.deletingLastPathComponent()
  }
}

private extension Data {
  static func extractTestData() -> Data {
    let url = URL.testsPath().appendingPathComponent("Resources/TestModels.json")
    do {
      let data = try Data(contentsOf: url)
      let json = try JSONSerialization.jsonObject(with: data, options: [])
      print("Did load data\n\(json)")
      return data
    } catch {
      fatalError("Can't open \(url): \(error)")
    }
  }
}

final class EasyCodableTests: XCTestCase {
  private lazy var testData = Data.extractTestData()
  
  func testDecode() {
    do {
      let models = try JSONDecoder().decode([TestModel].self, from: testData)
      models.enumerated().forEach {
        print("Item \($0.offset)")
        print($0.element)
      }
    } catch {
      XCTFail("\(error)")
    }
  }
  
  static var allTests = [
    ("testDecode", testDecode),
  ]
}
