//
//  DrinkResult.swift
//  CocktailDB
//
//  Created by Javier Castañeda on 04/03/26.
//

import Foundation

struct SearchReponse: Decodable {
    let drinks: [Drink]
    
    enum CodingKeys: String, CodingKey {
        case drinks
    }
}
