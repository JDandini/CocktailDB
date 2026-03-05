//
//  NetworkClient.swift
//  CocktailDB
//
//  Created by Javier Castañeda on 05/03/26.
//

import Foundation

protocol DataFetchable {
    func fetchData(for request: URLRequest)async throws -> Data
}

extension URLSession: DataFetchable {
    func fetchData(for request: URLRequest)async throws -> Data {
        let (data, response) = try await self.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkingError.invalidResponse
        }
        switch httpResponse.statusCode {
        case 200 ... 299:
            return data
        default:
            throw NetworkingError.invalidResponse
        }
    }
}

protocol NetworkRequester {
    func data<T: Decodable>(for request: NetworkRequest)async throws -> T
}

final class NetworkClient: NetworkRequester {
    private let networkFetcher: DataFetchable
    private lazy var decoder: JSONDecoder = {
        JSONDecoder()
    }()
    
    init(networkFetcher: DataFetchable = URLSession.shared) {
        self.networkFetcher = networkFetcher
    }
    
    func data<T: Decodable>(for request: NetworkRequest)async throws -> T {
        let urlRequest = try request.urlRequest()
        let data = try await networkFetcher.fetchData(for: urlRequest)
        return try decoder.decode(T.self, from: data)
    }
}
