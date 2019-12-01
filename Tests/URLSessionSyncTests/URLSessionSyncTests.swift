import XCTest
@testable import URLSessionSync

final class URLSessionSyncTests: XCTestCase {
  func testSync() throws {
    // {"latitude": 45.5070669, "longitude": -73.5565524}
    let urlString = "data:text/plain;charset=utf-8;base64,eyJsYXRpdHVkZSI6IDQ1LjUwNzA2NjksICJsb25naXR1ZGUiOiAtNzMuNTU2NTUyNH0="
    
    struct Coordinates: Decodable {
      let latitude: Double
      let longitude: Double
    }
    
    let result = try URLSession.shared.sync(urlString).decoding(Coordinates.self)
    XCTAssert(result.latitude == 45.5070669)
    XCTAssert(result.longitude == -73.5565524)
  }
  
  static var allTests = [
    ("testSync", testSync),
  ]
}
