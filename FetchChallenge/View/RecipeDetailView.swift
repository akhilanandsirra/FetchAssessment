//
//  RecipeDetailView.swift
//  FetchChallenge
//
//  Created by Akhil Anand Sirra on 14/06/23.
//

import SwiftUI

struct RecipeDetailView: View {
    @StateObject private var viewModel = RecipeDetailViewModel()
    let mealID: String, imageView = UIImageView()
    
    var body: some View {
        ScrollView {
            VStack {
                if let strMeal = viewModel.recipeData[mealID]?.meals.first?["strMeal"], let unwrappedStrMeal = strMeal {
                    Text(unwrappedStrMeal)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                } else {
                    Text("Meal Name Unavailable")
                }
                
                if let imageUrlString = viewModel.recipeData[mealID]?.meals.first?["strMealThumb"],
                   let imageUrl = URL(string: imageUrlString!) {
                    ImageView(imageUrl: imageUrl, placeholderImage: UIImage(named: "Default-Photo"))
                        .frame(height: 200)
                        .cornerRadius(4)
                } else {
                    Image(systemName: "photo")
                        .frame(width: 200, height: 200)
                        .cornerRadius(4)
                }
                
                
                if let area = viewModel.recipeData[mealID]?.meals.first?["strArea"], let unwrappedArea = area {
                    Text("Country of Origin: \(unwrappedArea)").padding()
                } else {
                    Text("Country of Origin: Unknown").padding()
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Ingredients & Measurements:")
                        .font(.headline)
                    if let recipe = viewModel.recipeData[mealID] {
                        Text(viewModel.fetchIngredients(for: recipe))
                    } else {
                        Text("Recipe not found")
                    }
                    Spacer()
                    Text("Recipe:")
                        .font(.headline)
                    if let strInstructions = viewModel.recipeData[mealID]?.meals.first?["strInstructions"], let strInstructions = strInstructions {
                        Text(strInstructions).padding()
                    } else {
                        Text("No Instructions Available").padding()
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(25)
                
                if let youtubeURLString = viewModel.recipeData[mealID]?.meals.first?["strYoutube"], let url = youtubeURLString {
                    Link(destination: URL(string: url)!, label: {
                        Label("Watch Video", systemImage: "play.rectangle.fill")
                            .font(.system(size: 18).bold())
                            .padding(15)
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(10)
                    })
                    .padding()
                }
            }
        }
        .task {
            if viewModel.recipeData[mealID] == nil {
                await viewModel.fetchRecipeData(for: mealID)
            }
        }
        .alert("", isPresented: $viewModel.hasError) {} message: {
            Text(viewModel.errorMessage)
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(mealID: Meal.sampleData[0].id)
    }
}


