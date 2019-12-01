//
//  HTTPHeaders.swift
//

/**
 Initialize by:
 - `["A": "1", "B": "2"]` (`HTTPHeaders` conforms to `ExpressibleByDictionaryLiteral`)
 - `HTTPHeaders.from(value)` where `value` is `Encodable` to a JSON object of type `[String: String]`
 */
public enum HTTPHeaders {
  case dictionary([String: String])
}

extension HTTPHeaders: ExpressibleByDictionaryLiteral {
  public init(dictionaryLiteral elements: (String, String)...) {
    self = .dictionary(.init(uniqueKeysWithValues: elements))
  }
}

public extension HTTPHeaders {
  static func from<T: Encodable>(_ value: T) throws -> HTTPHeaders {
    return try .dictionary(value.converted())
  }
}

internal extension HTTPHeaders {
  var dictionary: [String: String] {
    switch self { case .dictionary(let dictionary): return dictionary }
  }
}
