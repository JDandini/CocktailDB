//
//  ContentView.swift
//  CocktailDB
//
//  Created by Javier Castañeda on 04/03/26.
//

import SwiftUI

struct ContentView: View {
    let model: SearchViewModel
    @State private var drinks: [Drink] = []
    var body: some View {
        List(drinks) { drink in
            Text(drink.name)
        }
        .task {
            do {
                drinks = try await model.searchForDrink(drinkName: "margarita")
                print("Data \(drinks)")
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    let client = NetworkClient()
    let model = SearchViewModel(client: client)
    ContentView(model: model)
}
