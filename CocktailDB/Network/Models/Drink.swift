//
//  Drink.swift
//  CocktailDB
//
//  Created by Javier Castañeda on 04/03/26.
//

import Foundation

struct Drink: Decodable, Identifiable {
    let id: String
    let name: String
    let tags: String?
    let glassType: String
    let preparation: String
    let imageURL: String?
}

extension Drink {
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case tags = "strTags"
        case glassType = "strGlass"
        case preparation = "strInstructions"
        case imageURL = "strDrinkThumb"
    }
}
