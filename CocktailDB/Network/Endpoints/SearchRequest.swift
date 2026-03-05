//
//  SearchRequest.swift
//  CocktailDB
//
//  Created by Javier Castañeda on 05/03/26.
//

import Foundation

struct SearchRequest: NetworkRequest {
    var path: String {
        String(format: "search.php?s=%@", searchTerm)
    }
    let parameters: (any Encodable)? = .none
    let searchTerm: String
}
