//
//  Search.swift
//  CocktailDB
//
//  Created by Javier Castañeda on 04/03/26.
//

import Foundation

struct SearchRequest: NetworkRequest {
    let method: HTTPMethod = .get
    let parameters: (any Encodable)? = nil
    var path: String {
       String(format: "search.php?s=%@", searchTerm)
    }
    let searchTerm: String
}
