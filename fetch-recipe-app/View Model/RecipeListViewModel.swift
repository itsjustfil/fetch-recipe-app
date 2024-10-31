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
        case error
        case empty
    }
    
    enum NetworkError: Error {
        case emptyResponse
        case invalidData
    }

    @Published var recipes = [Recipe]()
    @Published var loadingState: LoadingState = .loading
    
    @MainActor
    func fetchData(from url: URL = URL.goodUrl) async {
        do {

            loadingState = .loading
            
            guard url == URL.goodUrl else {
                if url == URL.emptyUrl {
                    throw NetworkError.emptyResponse
                } else if url == URL.badUrl {
                    throw NetworkError.invalidData
                }
                return
            }
            
            let (data, _) = try await URLSession.shared.data(from: URL.goodUrl)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let recipeData = try decoder.decode(RecipeData.self, from: data)
            self.recipes = recipeData.recipes
            
            loadingState = .loaded
        } catch NetworkError.invalidData {
            loadingState = .error
        } catch NetworkError.emptyResponse {
            loadingState = .empty
        } catch {
            print(String(describing: error))
        }
    }
}
