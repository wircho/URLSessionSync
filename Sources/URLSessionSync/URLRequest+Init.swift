//
//  URLRequest+Init.swift
//

import Foundation

public extension URLRequest {
  init<U: URLConvertible>(method: HTTPMethod, url: U, body: HTTPBody = .none, headers: HTTPHeaders? = nil) {
    var request = URLRequest(url: url.toURL())
    request.httpMethod = method.rawValue
    request.allHTTPHeaderFields = headers?.dictionary
    request.httpBody = body.data
    self = request
  }
}
