//
//  CocktailDBApp.swift
//  CocktailDB
//
//  Created by Javier Castañeda on 04/03/26.
//

import SwiftUI

@main
struct CocktailDBApp: App {
    var body: some Scene {
        WindowGroup {
            let model = SearchViewModel()
            SearchView(model: model)
        }
    }
}
