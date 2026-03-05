//
//  NetworkRequest.swift
//  CocktailDB
//
//  Created by Javier Castañeda on 05/03/26.
//

import Foundation

typealias HTTPHeaders = [String: String]

enum HTTPMethod: String {
    case get
    case post
    case put
    case patch
    case delete
}

enum NetworkingError: Error {
    case invalidURL
    case invalidResponse
}

protocol NetworkRequest {
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var baseURL: URL? { get }
    var path: String { get }
    var parameters: Encodable? { get }
    var timeout: TimeInterval { get }
}

extension NetworkRequest {
    var method: HTTPMethod { .get }
    var headers: HTTPHeaders? { .none }
    var baseURL: URL? {
        URL(string: "https://www.thecocktaildb.com/api/json/v1/1/")
    }
    var timeout: TimeInterval { 10 }
    
    func urlRequest()throws -> URLRequest {
        guard var url = baseURL?.appending(path: path) else {
            throw NetworkingError.invalidURL
        }
        if path.contains("?"),
           let baseURL,
           let urlWithoutScaping = URL(string: baseURL.absoluteString + path) {
            url = urlWithoutScaping
        }
        
        var defaultHeaders = HTTPHeaders()
        if let headers {
            for (key, value) in headers {
                defaultHeaders[key] = value
            }
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue.uppercased()
        request.allHTTPHeaderFields = defaultHeaders
        request.timeoutInterval = timeout
        request.httpBody = try parameters?.toJSONData()
        return request
    }
}

extension Encodable {
    func toJSONData()throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(self)
    }
}
