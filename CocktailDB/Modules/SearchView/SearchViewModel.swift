//
//  SearchViewModel.swift
//  CocktailDB
//
//  Created by Javier Castañeda on 04/03/26.
//

import Foundation

final class SearchViewModel {
    private let client: NetworkRequester
    
    init(client: NetworkRequester) {
        self.client = client
    }
    
    func searchForDrink(drinkName: String)async throws -> [Drink] {
        let request = Search(searchTerm: drinkName)
        let result: DrinkResult = try await client.data(for: request)
        return result.drinks
    }
}
