//
//  URLSession+Sync.swift
//

import Foundation

/**
 Sample usage:
 - `let data = try URLSession.shared.sync("http://google.com").data`
 - `let string = try URLSession.shared.sync("http://google.com").string`
 - `let value = try URLSession.shared.sync("http://some-api-url").decoding(SomeStruct.self)`
 */
public struct URLSessionResult {
  public let data: Data
  public let response: URLResponse?
  
  fileprivate init(data: Data, response: URLResponse?) {
    self.data = data
    self.response = response
  }
}

public extension URLSessionResult {
  var string: String? { return String(data: data, encoding: .utf8) }
  
  func decoding<T: Decodable>(_ type: T.Type = T.self) throws -> T {
    let result = try data.decoding(T.self)
    return result
  }
}

public extension URLSession {
  func sync<R: URLRequestConvertible>(_ request: R) throws -> URLSessionResult {
    let semaphore = DispatchSemaphore(value: 0)
    var data: Data? = nil
    var response: URLResponse? = nil
    var error: Error? = nil
    let task = dataTask(with: request.toURLRequest()) {
      data = $0
      response = $1
      error = $2
      semaphore.signal()
    }
    task.resume()
    _ = semaphore.wait(timeout: .distantFuture)
    if let error = error { throw error }
    guard let unwrappedData = data else { throw URLRequestError.unexpectedNilData }
    return .init(data: unwrappedData , response: response)
  }
}

