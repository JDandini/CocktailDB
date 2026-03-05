//
//  Drink.swift
//  CocktailDB
//
//  Created by Javier Castañeda on 05/03/26.
//

import Foundation

struct Drink: Decodable, Identifiable {
    let id: String
    let name: String
    let tags: String?
    let category: String?
    let glassType: String
    let instructions: String
    let imageURLString: String
}

extension Drink {
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case tags = "strTags"
        case category = "strCategory"
        case glassType = "strGlass"
        case instructions = "strInstructions"
        case imageURLString = "strDrinkThumb"
    }
}
