//
//  Wrap.swift
//

/**
 An internal "Box" class which I decided to call Wrap.
 */
internal struct Wrap<T> {
  let wrapped: T
  init(_ wrapped: T) { self.wrapped = wrapped }
}

extension Wrap: Encodable where T: Encodable {}
extension Wrap: Decodable where T: Decodable {}


