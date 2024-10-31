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

    @Published var recipes = [Recipe]()
    @Published var loadingState: LoadingState = .loading
    
    private let service: RecipeService
    
    init(service: RecipeService = RecipeService()) {
        self.service = service
    }
    
    @MainActor
    func fetchData(from url: URL = URL.goodUrl) async {
        do {
            loadingState = .loading
            let data = try await service.fetchData(from: url)
            recipes = data
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
