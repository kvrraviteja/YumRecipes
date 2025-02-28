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

protocol RecipesNetworkService {
    func dataForRequest<T: Decodable>(_ request: URLRequest) async throws -> T
}

class RecipesNetworkManager: RecipesNetworkService {
    static let shared = RecipesNetworkManager()
    private let session: URLSession
    
    private init() {
        session = URLSession.shared
    }
    
    func dataForRequest<T: Decodable>(_ request: URLRequest) async throws -> T {
        let data: Data
        
        do {
            data = try await session.data(for: request).0
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
