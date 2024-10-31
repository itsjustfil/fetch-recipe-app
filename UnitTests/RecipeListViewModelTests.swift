//
//  RecipeListViewModelTests.swift
//  UnitTests
//
//  Created by Filip Brej on 10/31/24.
//

import Testing
import Foundation
@testable import fetch_recipe_app

struct RecipeListViewModelTests {
    
    @Test
    func emptyState() async throws {
        let viewModel = RecipeListViewModel()
        await viewModel.fetchData(from: URL.emptyUrl)
        
        #expect(viewModel.recipes.count == 0)
    }
    
    @Test
    func badUrl() async throws {
        let viewModel = RecipeListViewModel()
        await viewModel.fetchData(from: URL.badUrl)
        
        #expect(viewModel.recipes.count == 0)
    }
    
    @Test
    func goodUrl() async throws {
        let viewModel = RecipeListViewModel()
        await viewModel.fetchData(from: URL.goodUrl)
        
        #expect(viewModel.recipes.count > 0)
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
    
    @Test
    func missingFields() {
        let jsonData = """
        {
            "uuid": "1",
            "cuisine": "Italian",
        }
        """.data(using: .utf8)!
        
        let recipe = try? JSONDecoder().decode(Recipe.self, from: jsonData)
        #expect(recipe == nil)
    }
}
