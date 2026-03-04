//
//  RequestError.swift
//  CocktailDB
//
//  Created by Javier Castañeda on 04/03/26.
//

import Foundation

enum RequestError: Error {
    case invalidBaseURL
    case invalidResponse
    case responseError(Error)
    case decodingError(Error)
}
