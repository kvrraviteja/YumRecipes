//
//  RecipeImage.swift
//  YumRecipes
//
//  Created by Ravi Theja Karnatakam on 2/26/25.
//

import SwiftUI

struct RecipeImage: View {
    @StateObject private var imageLoader = RecipeImageLoader()
    @State private var isFullscreen = false
    
    var recipe: RecipeModel
    
    var body: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                    .shadow(radius: 5)
                    .onTapGesture {
                        isFullscreen = true
                    }
                    .fullScreenCover(isPresented: $isFullscreen) {
                        RecipeFullscreenImage(isPresented: $isFullscreen,
                                              recipe: recipe)
                    }
                    
            } else {
                ProgressView()
            }
        }
        .onAppear {
            imageLoader.fetchImage(recipe.smallImageURL)
        }
    }
}

#Preview {
    RecipeImage(recipe: RecipeModel.sample)
}
