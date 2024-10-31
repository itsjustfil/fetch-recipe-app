//
//  URL+Ext.swift
//  fetch-recipe-app
//
//  Created by Filip Brej on 10/31/24.
//

import Foundation

extension URL {
    static let goodUrl = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
    static let emptyUrl = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")!
    static let badUrl = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")!
}
