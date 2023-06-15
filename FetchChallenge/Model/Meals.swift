//
//  Meals.swift
//  FetchChallenge
//
//  Created by Akhil Anand Sirra on 14/06/23.
//

import Foundation

// MARK: - Meals
struct Meals: Codable {
    let meals: [Meal]
}

// MARK: - Meal
struct Meal: Codable {
    let id: String
    let strMeal: String
    let strMealThumb: URL
}

extension Meal {
    enum CodingKeys: String, CodingKey {
        case strMeal, strMealThumb
        case id = "idMeal"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.strMeal = try container.decode(String.self, forKey: .strMeal)
        let thumbnailString = try container.decode(String.self, forKey: .strMealThumb)
        self.strMealThumb = URL(string: thumbnailString)!
        self.id = try container.decode(String.self, forKey: .id)
    }
}

extension Meal {
    static let sampleData = [
        Meal(id: "53049", strMeal: "Apam balik", strMealThumb: URL(string: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")!),
        Meal(id: "52893", strMeal: "Apple & Blackberry Crumble", strMealThumb: URL(string: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg")!)
    ]
    
    static let sampleJSON = """
{"meals":[{"strMeal":"Apam balik","strMealThumb":"https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg","idMeal":"53049"},{"strMeal":"Apple & Blackberry Crumble","strMealThumb":"https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg","idMeal":"52893"}]}
"""
}


