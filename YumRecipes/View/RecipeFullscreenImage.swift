//
//  RecipeFullscreenImage.swift
//  YumRecipes
//
//  Created by Ravi Theja Karnatakam on 2/26/25.
//

import SwiftUI

struct RecipeFullscreenImage: View {
    @StateObject private var imageLoader = RecipeImageLoader()
    @Binding var isPresented: Bool
    
    var recipe: RecipeModel
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            Group {
                if let image = imageLoader.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .onTapGesture {
                            isPresented = false
                        }
                        
                } else {
                    ProgressView()
                }
            }
            .onAppear {
                imageLoader.fetchImage(recipe.largeImageURL)
            }
        }
    }
}

#Preview {
    RecipeImage(recipe: RecipeModel.sample)
}
