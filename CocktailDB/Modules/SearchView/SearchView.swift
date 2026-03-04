//
//  ContentView.swift
//  CocktailDB
//
//  Created by Javier Castañeda on 04/03/26.
//

import Kingfisher
import SwiftUI

struct SearchView: View {
    let model: SearchViewModel
    @State private var drinks: [Drink] = []
    @State private var searchText: String  = ""
    
    var body: some View {
        NavigationStack {
            List(drinks) { drink in
                NavigationLink {
                    DrinkDetail(viewModel: DetailViewModel(drink: drink))
                } label: {
                    HStack {
                        KFImage(URL(string: drink.imageURL ?? ""))
                            .resizable()
                            .serialize(as: .PNG)
                            .frame(width: 64, height: 64)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        Text(drink.name)
                    }
                }

            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $searchText)
            .onChange(of: searchText) {_, newValue in
                Task {
                    do {
                        try await Task.sleep(for: .milliseconds(500))
                        try Task.checkCancellation()
                        drinks = try await model.searchForDrink(drinkName: searchText)
                    } catch {
                        print(error)
                    }
                }
            }
            
        }
    }
}

#Preview {
    let client = NetworkClient()
    let model = SearchViewModel(client: client)
    SearchView(model: model)
}
