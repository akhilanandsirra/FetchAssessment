//
//  FetchChallengeTests.swift
//  FetchChallengeTests
//
//  Created by Akhil Anand Sirra on 13/06/23.
//

import XCTest
@testable import FetchChallenge

final class FetchChallengeTests: XCTestCase {
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private let networkingLayer: GenericAPI = NetworkingLayer()
    
    private let mealsURL = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    private let mealDetailsURL = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    
    func testDecodingSampleMeals() throws {
        _ = try decoder.decode(Meals.self, from: Meal.sampleJSON.data(using: .utf8)!)
    }
    
    func testDecodingSampleRecipe() throws {
        _ = try decoder.decode(Recipe.self, from: Recipe.sampleJSON.data(using: .utf8)!)
    }
    
    func testRequestAndDecodeMealsAPI() async throws {
        let _: Meals = try await networkingLayer.request(mealsURL)
    }
    
    func testRequestAndDecodeTestRecipeAPI() async throws {
        let _: Recipe = try await networkingLayer.request(mealDetailsURL + "53049")
    }    
}
