//
//  URLConvertible.swift
//

import Foundation

public protocol URLRequestConvertible { func toURLRequest() -> URLRequest }
extension URLRequest: URLRequestConvertible { public func toURLRequest() -> URLRequest { return self } }

public protocol URLConvertible: URLRequestConvertible { func toURL() -> URL }
extension URLConvertible { public func toURLRequest() -> URLRequest { return .init(url: toURL()) } }
extension URL: URLConvertible { public func toURL() -> URL { return self } }
extension String: URLConvertible { public func toURL() -> URL { return URL(string: self)! } }
