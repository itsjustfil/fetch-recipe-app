//
//  Recipe.swift
//  fetch-recipe-app
//
//  Created by Filip Brej on 10/31/24.
//


struct RecipeData: Codable {
    let recipes: [Recipe]
}

struct Recipe: Codable, Identifiable {
    let cuisine: String
    let name: String
    let photoUrlLarge: String?
    let photoUrlSmall: String?
    let sourceUrl: String?
    var id: String
    let youtubeUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photoUrlLarge
        case photoUrlSmall
        case sourceUrl
        case id = "uuid"
        case youtubeUrl
    }
}
