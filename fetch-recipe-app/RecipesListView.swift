//
//  RecipesListView.swift
//  fetch-recipe-app
//
//  Created by Filip Brej on 10/31/24.
//

import SwiftUI

struct RecipesListView: View {
    
    private let apiUrl = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    private let malformedUrl = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
    private let emptyUrl = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
    
    @State private var recipeData = RecipeData(recipes: [])
    
    var body: some View {
        NavigationStack {
            List(recipeData.recipes) { recipe in
                RecipeCell(recipe: recipe)
            }
            .task { await fetchData() }
            .navigationTitle("Recipes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task { @MainActor in
                            await fetchData()
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .tint(.black)
                    }
                }
            }
        }
    }
    
    @MainActor
    private func fetchData() async {
        do {
            let (data, _) = try await URLSession.shared.data(from: URL(string: apiUrl)!)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let recipeData = try decoder.decode(RecipeData.self, from: data)
            self.recipeData = recipeData
        } catch {
            print(error.localizedDescription)
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
