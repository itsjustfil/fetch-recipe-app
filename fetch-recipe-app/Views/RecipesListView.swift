//
//  RecipesListView.swift
//  fetch-recipe-app
//
//  Created by Filip Brej on 10/31/24.
//

import SwiftUI

struct RecipesListView: View {
    
    @ObservedObject private var viewModel = RecipeListViewModel()

    var body: some View {
        NavigationStack {
            mainView
            .navigationTitle("Recipes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task { await viewModel.fetchData() }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .tint(.primary)
                    }
                }
            }
        }
    }
    
    private var listView: some View {
        List(viewModel.recipes) { recipe in
            RecipeCell(recipe: recipe)
        }
    }
    
    private var mainView: some View {
        Group {
            switch viewModel.loadingState {
            case .loading:
                ProgressView()
            case .loaded:
                listView
            case .error:
                ContentUnavailableView("No recipes found.", systemImage: "fork.knife", description: Text("Please refresh the page to try again."))
            case .empty:
                ContentUnavailableView("An error occurred.", systemImage: "fork.knife", description: Text("Please refresh the page to try again."))
            }
        }
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

#Preview {
    RecipesListView()
}
