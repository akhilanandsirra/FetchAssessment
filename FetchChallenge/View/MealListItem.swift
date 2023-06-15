//
//  MealListItem.swift
//  FetchChallenge
//
//  Created by Akhil Anand Sirra on 14/06/23.
//

import SwiftUI

struct MealListItem: View {
    let meal: Meal
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 12) {
                ImageView(imageUrl: meal.strMealThumb, placeholderImage: UIImage(named: "Default-Photo"))
                    .frame(height: 70)
                    .cornerRadius(4)
                Text(meal.strMeal)
                    .font(.headline)
            }
        }
        .padding()
    }
}

struct MealListItem_Previews: PreviewProvider {
    static var previews: some View {
        MealListItem(meal: Meal.sampleData[0])
    }
}
