//
//  Encodable+Converted.swift
//

import Foundation

/**
 Converting Encodable to Decodable using JSONEncoder and JSONDecoder
 */
internal extension Encodable {
  func converted<T: Decodable>(to type: T.Type = T.self) throws -> T {
    return try Data(wrapping: self).unwrapping(T.self)
  }
}
