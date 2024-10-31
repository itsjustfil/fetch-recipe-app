//
//  RecipeListViewModel.swift
//  fetch-recipe-app
//
//  Created by Filip Brej on 10/31/24.
//

import Foundation

final class RecipeListViewModel: ObservableObject {
    
    enum LoadingState {
        case loading
        case loaded
        case empty
        case error
    }

    private let apiUrl = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    private let malformedUrl = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
    private let emptyUrl = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
        
    @Published private(set) var recipes = [Recipe]()
    @Published private(set) var loadingState: LoadingState = .loading
    
    init() {
        Task { await fetchData() }
    }
    
    @MainActor
    func fetchData(from urlString: String = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") async {
        do {
            guard let url = URL(string: apiUrl) else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let recipeData = try decoder.decode(RecipeData.self, from: data)
            self.recipes = recipeData.recipes
        } catch {
            print(String(describing: error))
        }
    }
}
