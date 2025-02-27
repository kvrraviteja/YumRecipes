//
//  RecipesNetworkManager.swift
//  YumRecipes
//
//  Created by Ravi Theja Karnatakam on 2/25/25.
//

import Foundation

enum NetworkManagerError: Error, Equatable {
    case failedToFetchData
    case failedToParseResponse
}

class RecipesNetworkManager {
    static let shared = RecipesNetworkManager()
    
    private init() { }
    
    func dataForRequest<T>(_ request: URLRequest) async throws -> T where T: Codable {
        let data: Data
        
        do {
            data = try await URLSession.shared.data(for: request).0
        } catch {
            throw NetworkManagerError.failedToFetchData
        }
        
        do {
            let response = try JSONDecoder().decode(T.self, from: data)
            return response
        } catch {
            throw NetworkManagerError.failedToParseResponse
        }
    }
}
