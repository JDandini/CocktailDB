//
//  DrinkDetail.swift
//  CocktailDB
//
//  Created by Javier Castañeda on 04/03/26.
//

import Kingfisher
import SwiftUI

struct DrinkDetail: View {
    let viewModel: DetailViewModel
    var body: some View {
        ScrollView {
            VStack {
                Text(viewModel.name)
                    .font(.largeTitle)
                KFImage(viewModel.imageURL)
                    .resizable()
                    .serialize(as: .PNG)
                    .frame(width: 300, height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.bottom, 10)
                Text("How to prepare:")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                Text(viewModel.preparation)
            }
            .padding()
        }
    }
}

#Preview {
    let drink = Drink(
        id: "id",
        name: "Some Drink",
        tags: "tag 1, tag2",
        glassType: "High glass",
        preparation: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
        imageURL: "https://www.thecocktaildb.com/images/media/drink/5noda61589575158.jpg")
    let viewModel = DetailViewModel(drink: drink)
    DrinkDetail(viewModel: viewModel)
}
