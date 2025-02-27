//
//  RecipeRow.swift
//  YumRecipes
//
//  Created by Ravi Theja Karnatakam on 2/26/25.
//

import SwiftUI

struct RecipeRow: View {
    var recipe: RecipeModel
    
    var body: some View {
        HStack {
            RecipeImage(recipe: recipe)
                .frame(width: 100, height: 100, alignment: .center)
            
            VStack(alignment: .leading) {
                Text(recipe.recipeName)
                    .font(.headline)
                Text(recipe.cuisine)
                    .foregroundStyle(.gray)
                    .font(.subheadline)
            }
            .padding()
            .font(.system(size: 20))
        }
        
    }
}

#Preview {
    RecipeRow(recipe: RecipeModel.sample)
}
