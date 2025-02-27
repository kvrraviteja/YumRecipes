//
//  RecipeImageLoader.swift
//  YumRecipes
//
//  Created by Ravi Theja Karnatakam on 2/26/25.
//

import SwiftUI

class RecipeImageLoader: ObservableObject {
    @Published var image: UIImage?
        
    func fetchImage(_ urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        
        // Cache lookup first.
        if let cachedImage = RecipeImageCache.shared.image(url) {
            image = cachedImage
            return
        }
        
        // Download image, if not found in cache.
        Task {
            do {
                let (imageData, _) = try await URLSession.shared.data(from: url)
                if let image = UIImage(data: imageData) {
                    await MainActor.run { [weak self] in
                        guard let self = self else { return }
                        self.image = image
                        RecipeImageCache.shared.set(image, key: url)
                    }
                }
            }
        }
    }
}


class RecipeImageCache {
    static let shared = RecipeImageCache()

    private let cache = NSCache<NSURL, UIImage>()
    
    private init() { }
    
    func image(_ key: URL) -> UIImage? {
        return cache.object(forKey: key as NSURL)
    }
    
    func set(_ image: UIImage, key: URL) {
        self.cache.setObject(image, forKey: key as NSURL)
    }
}

