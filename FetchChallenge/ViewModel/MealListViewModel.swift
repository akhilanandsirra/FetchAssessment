//
//  MealListViewModel.swift
//  FetchChallenge
//
//  Created by Akhil Anand Sirra on 14/06/23.
//

import Foundation

@MainActor
final class MealListViewModel: ObservableObject {
    private let networkingLayer: GenericAPI = NetworkingLayer()
    
    @Published private(set) var mealsData = [Meal]()
    @Published private(set) var errorMessage: String = ""
    @Published var hasError: Bool = false
    private let mealsURL = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    
    @Published var searchText: String = ""
    
    var searchResults: [Meal] {
        if searchText.isEmpty {
            return mealsData // if search is empty return unfiltered data
        } else {
            return mealsData.filter { $0.strMeal.lowercased().contains(searchText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)) }
        }
    }
    
    func fetchMealData() async {
        async let callMeals: Void = fetchMeals()
        let _ = await [callMeals]
    }
    
    private func fetchMeals() async {
        do {
            let meals: Meals = try await networkingLayer.request(mealsURL)
            mealsData = meals.meals.map { $0 }
            mealsData.sort { $0.strMeal < $1.strMeal }
        } catch {
            errorMessage = error.localizedDescription
            hasError = true
            dump(error)
        }
    }
}
