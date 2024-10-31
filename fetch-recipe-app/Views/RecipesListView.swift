//
//  RecipesListView.swift
//  fetch-recipe-app
//
//  Created by Filip Brej on 10/31/24.
//

import SwiftUI

struct RecipesListView: View {
    
    @ObservedObject var viewModel: RecipeListViewModel
    
    // Counter used to help simulate using the empty and bad URLs to update the UI.
    @State private var fetchCounter = 0
    
    var body: some View {
        NavigationStack {
            ScrollView {
                rootView
            }
            .refreshable {
                Task {
                    if fetchCounter == 0 {
                        await viewModel.fetchData()
                    } else if fetchCounter == 1 {
                        await viewModel.fetchData(from: URL.badUrl)
                    } else if fetchCounter == 2 {
                        await viewModel.fetchData(from: URL.emptyUrl)
                    } else {
                        fetchCounter = 0
                        return
                    }
                    fetchCounter += 1
                }
            }
            .navigationTitle("Recipes")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var rootView: some View {
        Group {
            switch viewModel.loadingState {
            case .loading:
                ProgressView()
            case .loaded:
                listView
            case .error:
                errorView
            case .empty:
                emptyView
            }
        }
    }
    
    private var listView: some View {
        VStack {
            ForEach(viewModel.recipes) { recipe in
                RecipeCell(recipe: recipe)
            }
        }.padding()
    }
    
    private var errorView: some View {
        ContentUnavailableView(
            "No recipes found.",
            systemImage: "fork.knife",
            description: Text("Please refresh the page to try again.")
        )
    }
    
    private var emptyView: some View {
        ContentUnavailableView(
            "An error occurred.",
            systemImage: "fork.knife",
            description: Text("Please refresh the page to try again.")
        )
    }
}

private struct RecipeCell: View {
    
    let recipe: Recipe
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            if let smallPhotoUrl = recipe.photoUrlSmall,
               let url = URL(string: smallPhotoUrl) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .frame(width: 80, height: 80)
                        .scaledToFit()
                } placeholder: {
                    Color.gray
                        .frame(width: 80, height: 80)
                        .scaledToFit()
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(recipe.name)
                    .font(.headline)
                Text(recipe.cuisine)
                    .font(.body)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
        }
    }
}
