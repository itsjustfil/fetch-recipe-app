//
//  RecipeService.swift
//  fetch-recipe-app
//
//  Created by Filip Brej on 10/31/24.
//

import Foundation

enum NetworkError: Error {
    case emptyResponse
    case invalidData
}

struct RecipeService {
    func fetchData(from url: URL = URL.goodUrl) async throws -> [Recipe] {
            guard url == URL.goodUrl else {
                if url == URL.emptyUrl {
                    throw NetworkError.emptyResponse
                } else if url == URL.badUrl {
                    throw NetworkError.invalidData
                }
                return []
            }
            
            let (data, _) = try await URLSession.shared.data(from: URL.goodUrl)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let recipeData = try decoder.decode(RecipeData.self, from: data)
            return recipeData.recipes
    }
}
