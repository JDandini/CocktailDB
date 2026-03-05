//
//  SearchViewModel.swift
//  CocktailDB
//
//  Created by Javier Castañeda on 05/03/26.
//
import Combine
import Foundation

protocol SearchViewModelProtocol {
    var client: NetworkRequester { get }
    func searchForDrinks(with term: String)async throws -> [Drink]
}

final class SearchViewModel: SearchViewModelProtocol {
    
    var client: any NetworkRequester
    private var cancellables = Set<AnyCancellable>()
    
    init(client: any NetworkRequester = NetworkClient()) {
        self.client = client
    }
    
    func searchForDrinks(with term: String)async throws -> [Drink] {
        let request = SearchRequest(searchTerm: term)
        let response: SearchResponse = try await client.data(for: request)
        return response.drinks
    }
}
