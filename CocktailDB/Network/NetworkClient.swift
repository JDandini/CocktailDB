//
//  NetworkClient.swift
//  CocktailDB
//
//  Created by Javier Castañeda on 04/03/26.
//

import Foundation

protocol HTTPDataDownloader {
    func httpData(for request: URLRequest) async throws -> Data
}

extension URLSession: HTTPDataDownloader {
    func httpData(for request: URLRequest) async throws -> Data {
        let (data, response) = try await self.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw RequestError.invalidResponse
        }
        switch httpResponse.statusCode {
        case 200 ... 299:
            return data
        default:
            throw RequestError.invalidResponse
        }
    }
}

protocol NetworkRequester{
    func data<T: Decodable>(for request: NetworkRequest)async throws -> T
}


final class NetworkClient: NetworkRequester {
    private var downloader: HTTPDataDownloader
    private lazy var decoder: JSONDecoder = {
        JSONDecoder()
    }()
    
    init(downloader: HTTPDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
    
    func data<T: Decodable>(for request: NetworkRequest)async throws -> T {
        let urlRequest = try request.makeRequest()
        let data = try await downloader.httpData(for: urlRequest)
        return try decoder.decode(from: data)
    }
}
