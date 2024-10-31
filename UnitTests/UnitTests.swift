//
//  UnitTests.swift
//  UnitTests
//
//  Created by Filip Brej on 10/31/24.
//

import Testing
import Foundation
@testable import fetch_recipe_app

struct UnitTests {

    @Test
    func emptyState() async throws {
        let viewModel = RecipeListViewModel()
        viewModel.recipes = []
        #expect(viewModel.recipes.count == 0)
    }

    
    @Test
    func recipeParsing() {
        let jsonData = """
        {
            "uuid": "1",
            "name": "Pasta",
            "cuisine": "Italian",
        }
        """.data(using: .utf8)!
        
        let recipe = try? JSONDecoder().decode(Recipe.self, from: jsonData)
        #expect(recipe != nil)
        #expect(recipe?.name == "Pasta")
        #expect(recipe?.cuisine == "Italian")
    }
}
