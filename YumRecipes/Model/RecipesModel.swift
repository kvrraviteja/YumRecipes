//
//  RecipesModel.swift
//  YumRecipes
//
//  Created by Ravi Theja Karnatakam on 2/25/25.
//

import Foundation

struct RecipeModel: Codable, Identifiable {
    let recipeName: String
    let cuisine: String
    let largeImageURL: String
    let smallImageURL: String
    let sourceURL: String?
    let uuid: String
    let youtubeURL: String?
    
    var id: String {
        return uuid
    }
    
    enum CodingKeys: String, CodingKey {
        case recipeName = "name"
        case cuisine = "cuisine"
        case largeImageURL = "photo_url_large"
        case smallImageURL = "photo_url_small"
        case uuid = "uuid"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
    
    static let sample = RecipeModel(recipeName: "Paneer masala",
                                    cuisine: "Indian",
                                    largeImageURL: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                                    smallImageURL: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                                    sourceURL: "",
                                    uuid: UUID().uuidString,
                                    youtubeURL: "")
}

class RecipesModel: Codable {
    let recipes: [RecipeModel]?
}

