//
//  DetailViewModel.swift
//  CocktailDB
//
//  Created by Javier Castañeda on 04/03/26.
//

import UIKit

final class DetailViewModel {
    private let drink: Drink
    
    init(drink: Drink) {
        self.drink = drink
    }
    
    lazy var imageURL: URL? = {
        guard let urlString = drink.imageURL else {
            return nil
        }
        return URL(string: urlString)
    }()
}
