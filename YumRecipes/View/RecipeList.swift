//
//  RecipeList.swift
//  YumRecipes
//
//  Created by Ravi Theja Karnatakam on 2/26/25.
//

import SwiftUI

struct RecipeList: View {
    @StateObject var viewModel = RecipesViewModel()    
    @State private var searchText = ""
    @State private var isRefreshing = false
    
    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                ProgressView("Loading recipes..")
                    .progressViewStyle(CircularProgressViewStyle())
            } else if viewModel.displayableRecipes.isEmpty {
                Text(viewModel.errorMessage)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.primary)
                    .padding()
            } else {
                List(viewModel.displayableRecipes) { recipe in
                    VStack {
                        RecipeRow(recipe: recipe)
                    }
                }
                .navigationTitle("Recipes")
                .searchable(text: $searchText)
                .onChange(of: searchText) {
                    viewModel.filterRecipes(searchText)
                }
                .refreshable {
                    if !isRefreshing {
                        refreshReceipes()
                    }
                }
            }
        }
        .onAppear {
            Task {
                try await viewModel.fetchRecipes(.all)
            }
        }
    }
    
    private func refreshReceipes() {
        isRefreshing = true
        Task {
            try await viewModel.fetchRecipes(.all)
            isRefreshing = false
        }
    }
}

#Preview {
    RecipeList()
}
