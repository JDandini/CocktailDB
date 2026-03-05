//
//  ContentView.swift
//  CocktailDB
//
//  Created by Javier Castañeda on 04/03/26.
//

import SwiftUI
import Kingfisher

struct SearchView: View {
    @State var drinks: [Drink] = []
    @State var searchText: String = ""
    let model: SearchViewModelProtocol
    
    var body: some View {
        NavigationStack {
            List(drinks) { drink in
                NavigationLink {
                    DrinkDetailView()
                } label: {
                    HStack {
                        KFImage(URL(string: drink.imageURLString))
                            .resizable()
                            .serialize(as: .PNG)
                            .frame(width: 64, height: 64)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        Text(drink.name)
                    }
                }
            }
            .navigationTitle("Search")
            .searchable(text: $searchText)
            .onChange(of: searchText) { _, value in
                guard !searchText.isEmpty else { return }
                Task {
                    do {
                        try await Task.sleep(for: .milliseconds(500))
                        try Task.checkCancellation()
                        drinks = try await model.searchForDrinks(with: value)
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}

#Preview {
    let model = SearchViewModel()
    SearchView(model: model)
}
