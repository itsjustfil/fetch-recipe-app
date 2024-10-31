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
    
    private var fetchCounter = 0

    init() {
        Task { await fetchData() }
    }
    
    
    private func getUrl() -> URL {
        var url: URL = URL.goodUrl
        
        
        if fetchCounter > 2 {
            fetchCounter = 0
        }
        
        if fetchCounter == 1 {
            url = URL.badUrl
        } else if fetchCounter == 2 {
            url = URL.emptyUrl
        }
        
        fetchCounter += 1
        
        return url
    }
    
    @MainActor
    func fetchData() async {
        do {
            
            let url = getUrl()

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
