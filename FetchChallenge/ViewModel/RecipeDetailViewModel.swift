//
//  ReceipeDetailViewModel.swift
//  FetchChallenge
//
//  Created by Akhil Anand Sirra on 14/06/23.
//

import Foundation

@MainActor
final class RecipeDetailViewModel: ObservableObject {
    private let networkingLayer: GenericAPI = NetworkingLayer()
    
    @Published private(set) var recipeData = [String: Recipe]()
    @Published private(set) var errorMessage: String = ""
    @Published var hasError: Bool = false
    private let mealDetailsURL = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    
    func fetchRecipeData(for mealID: String) async {
        async let callReceipes: Void = fetchRecipes(for: mealID)
        let _ = await [callReceipes]
    }
    
    private func fetchRecipes(for mealID: String) async {
        do {
            let recipe: Recipe = try await networkingLayer.request(mealDetailsURL + mealID)
            if let firstMeal = recipe.meals.first {
                recipeData[mealID] = Recipe(meals: [firstMeal])
            }
        } catch {
            errorMessage = error.localizedDescription
            hasError = true
            dump(error)
        }
    }
    
    func fetchIngredients(for recipeData: Recipe) -> String {
        var result = ""
        
        for i in 1...20 {
            let ingredientKey = "strIngredient\(i)"
            let measureKey = "strMeasure\(i)"
            
            guard let ingredient = recipeData.meals.first?[ingredientKey] as? String,
                  let measure = recipeData.meals.first?[measureKey] as? String,
                  !ingredient.isEmpty, !measure.isEmpty else {
                // Skip empty ingredients or measures
                continue
            }
            
            let formattedIngredient = "\(ingredient) - \(measure)"
            
            if result.isEmpty {
                result = formattedIngredient
            } else {
                result += "\n\(formattedIngredient)"
            }
        }
        
        return result
    }

}
