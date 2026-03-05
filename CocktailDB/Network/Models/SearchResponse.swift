//
//  SearchResponse.swift
//  CocktailDB
//
//  Created by Javier Castañeda on 05/03/26.
//

import Foundation

struct SearchResponse: Decodable {
    let drinks: [Drink]
}
