//
//  Dictionary+Escaping.swift
//

import Foundation

/**
 Dictionary to percent escaped URL query. From https://stackoverflow.com/questions/26364914/http-request-in-swift-with-post-method
 */
internal extension Dictionary where Key == String, Value == String {
  func percentEscaped() -> String {
    return map { (key, value) in
      let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
      let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
      return escapedKey + "=" + escapedValue
      }
      .joined(separator: "&")
  }
}

private extension CharacterSet {
  static let urlQueryValueAllowed: CharacterSet = {
    let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
    let subDelimitersToEncode = "!$&'()*+,;="
    var allowed = CharacterSet.urlQueryAllowed
    allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
    return allowed
  }()
}
