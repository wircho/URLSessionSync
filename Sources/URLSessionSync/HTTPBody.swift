//
//  HTTPBody.swift
//

import Foundation

/**
 Initialize by:
 - `"a=1&b=2"` (`HTTPBody` conforms to `ExpressibleByStringLiteral`)
 - `HTTPBody.json(someEcondableValue)`
 - `HTTPBody.params(["a": "1", "b": "2"])`
 - `HTTPBody.params(value)` where `value` is `Encodable` to a JSON object of type `[String: String]`
 */
public enum HTTPBody {
  case paramsDictionary([String: String])
  case stringData(Data)
  case jsonData(Data)
  case none
}

extension HTTPBody: ExpressibleByStringLiteral {
  public init(stringLiteral value: String) {
    self = .stringData(value.data(using: .utf8)!)
  }
}

public extension HTTPBody {
  static func json<T: Encodable>(_ value: T) throws -> HTTPBody {
    return try .jsonData(Data(encoding: value))
  }
  
  static func params(_ dictionary: [String: String]) -> HTTPBody {
    return .paramsDictionary(dictionary)
  }
  
  static func params<T: Encodable>(_ value: T) throws -> HTTPBody {
    return try .paramsDictionary(value.converted())
  }
}

internal extension HTTPBody {
  var data: Data? {
    switch self {
    case .none: return nil
    case .jsonData(let data): return data
    case .stringData(let data): return data
    case .paramsDictionary(let dictionary): return dictionary.percentEscaped().data(using: .utf8)
    }
  }
}
