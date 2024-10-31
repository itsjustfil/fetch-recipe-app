//
//  fetch_recipe_appApp.swift
//  fetch-recipe-app
//
//  Created by Filip Brej on 10/31/24.
//

import SwiftUI

@main
struct fetch_recipe_appApp: App {
    
    @ObservedObject private var viewModel = RecipeListViewModel()
    
    var body: some Scene {
        WindowGroup {
            RecipesListView(viewModel: viewModel)
                .task {
                    await viewModel.fetchData()
                }
        }
    }
}
