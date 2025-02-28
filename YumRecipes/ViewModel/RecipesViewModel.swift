//
//  RecipesViewModel.swift
//  YumRecipes
//
//  Created by Ravi Theja Karnatakam on 2/25/25.
//

import Foundation

enum ViewModelError: Error {
    case emptyRecipeList
}

class RecipesViewModel: ObservableObject {
    
    @Published var displayableRecipes = [RecipeModel]()
    @Published var errorMessage = ""
    @Published var isLoading = false

    let apiManager = RecipesAPIManager()
    var recipes = [RecipeModel]()

    func fetchRecipes(_ source: RecipesSource) async throws {
        await MainActor.run { [weak self] in
            guard let self = self else { return }
            self.isLoading = true
        }
        

        do {
            let recipesModel = try await apiManager.fetchRecipes(source)
            let response = recipesModel.recipes ?? [RecipeModel]()
            if response.isEmpty {
                throw ViewModelError.emptyRecipeList
            }

            await MainActor.run { [weak self] in
                guard let self = self else { return }
                self.recipes = response
                self.displayableRecipes = response
                self.isLoading = false
            }
        } catch {
            await MainActor.run { [weak self] in
                guard let self = self else { return }

                // Reset recipe list in case of error.
                self.recipes = [RecipeModel]()

                // Display user friendly message
                switch error {
                case NetworkManagerError.failedToFetchData:
                    self.errorMessage = "Check your network connection and retry"
                case NetworkManagerError.failedToParseResponse:
                    self.errorMessage = "Malformed recipes found"
                case APIManagerError.invalidURL:
                    self.errorMessage = "Invalid recipes source"
                case ViewModelError.emptyRecipeList:
                    self.errorMessage = "No recipes found"
                default:
                    self.errorMessage = "Unknown error occurred"
                }
                
                self.isLoading = false
            }
            
            throw error
        }
    }
    
    /// Filter recipes by name or cuisine
    func filterRecipes(_ searchKey: String) {
        if searchKey.replacingOccurrences(of: "\\s", with: "", options: .regularExpression) == "" {
            displayableRecipes = recipes
            return
        }
                
        displayableRecipes = recipes.filter { model in
            let matchesName = model.recipeName.lowercased().contains(searchKey.lowercased())
            let matchesCusine = model.cuisine.lowercased().contains(searchKey.lowercased())
            return matchesName || matchesCusine
        }
    }
}
