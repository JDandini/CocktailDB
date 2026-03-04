//
//  NetworkRequest.swift
//  CocktailDB
//
//  Created by Javier Castañeda on 04/03/26.
//

import Foundation
typealias HTTPHeaders = [String: String]

protocol NetworkRequest {
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: HTTPHeaders? { get }
    var baseURL: URL? { get }
    var timeout: TimeInterval { get }
    var parameters: Encodable? { get }
}

extension NetworkRequest {
    var headers: HTTPHeaders? { .none }
    var timeout: TimeInterval { 15 }
    var baseURL: URL? { URL(string: "https://www.thecocktaildb.com/api/json/v1/1/") }
    
    func makeRequest()throws -> URLRequest {
        guard var url = baseURL?.appendingPathComponent(path) else {
            throw RequestError.invalidBaseURL
        }
        // Set the path
        if path.contains("?"),
           let base = baseURL?.absoluteString,
           let urlWithoutSpace = URL(string: base + path) {
            url = urlWithoutSpace
        }
        // set headers
        var defaultHeaders = HTTPHeaders()
        if let headers {
            for (key, value) in headers {
                defaultHeaders[key] = value
            }
        }
        // build request
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.rawValue.uppercased()
        request.timeoutInterval = timeout
        request.httpBody = try parameters?.jsonData()
        
        return request
    }
}

extension Encodable {
    public func jsonData() throws -> Data {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        return data
    }
}

extension JSONDecoder {
    func decode<T: Decodable>(from data: Data) throws -> T {
        do {
            return try self.decode(T.self, from: data)
        } catch let error  {
            throw RequestError.decodingError(error)
        }
    }
}
