//
//  RecipesAPIManager.swift
//  YumRecipes
//
//  Created by Ravi Theja Karnatakam on 2/25/25.
//

import Foundation

enum APIManagerError: Error, Equatable {
    case invalidURL
}

enum RecipesSource {
    case all
    case empty
    case malformed
    case invalidSource
    
    var url: URL? {
        switch self {
        case .all:
            return URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
            
        case .empty:
            return URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")
            
        case .malformed:
            return URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")
            
        case .invalidSource:
            return nil
        }
    }
}

class RecipesAPIManager {
    func fetchRecipes(_ source: RecipesSource) async throws -> RecipesModel {
        guard let url = source.url else { throw APIManagerError.invalidURL }
        
        do {
            let request = URLRequest(url: url)
            let recipes: RecipesModel = try await RecipesNetworkManager.shared.dataForRequest(request)
            return recipes
        } catch {
            throw error
        }
    }
}
