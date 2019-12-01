//
//  Data+Coding.swift
//

import Foundation

/**
 Coding objects to or from Data.
 */
internal extension Data {
  init<T: Encodable>(encoding value: T) throws {
    self = try JSONEncoder().encode(value)
  }
  
  func decoding<T: Decodable>(_ type: T.Type = T.self) throws -> T {
    return try JSONDecoder().decode(T.self, from: self)
  }
}

/**
 Coding wrapped objects to or from Data.
 */
internal extension Data {
  init<T: Encodable>(wrapping value: T) throws {
    self = try JSONEncoder().encode(Wrap(value))
  }
  
  func unwrapping<T: Decodable>(_ type: T.Type = T.self) throws -> T {
    return try JSONDecoder().decode(Wrap<T>.self, from: self).wrapped
  }
}
