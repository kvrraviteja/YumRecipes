//
//  RecipeImageCacheTests.swift
//  YumRecipesTests
//
//  Created by Ravi Theja Karnatakam on 2/27/25.
//

import Testing
import SwiftUI
import XCTest
@testable import YumRecipes

struct RecipeImageCacheTests {

    @Test func testImageFoundInCache() {
        let cache = RecipeImageCache.shared
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg")
        cache.set(UIImage(), key: url)
        XCTAssertNotNil(cache.image(url), "Image exists in cache")
    }
    
    @Test func testImageNotFoundInCache() {
        let cache = RecipeImageCache.shared
        let uncachedURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361/large.jpg")
        XCTAssertNil(cache.image(uncachedURL), "Image should not exist in cache")
    }
    
    @Test func testRecipeSource() {
        XCTAssertTrue(RecipesSource.all.url == URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"))
        XCTAssertTrue(RecipesSource.empty.url == URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"))
        XCTAssertTrue(RecipesSource.malformed.url == URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"))
        XCTAssertNil(RecipesSource.invalidSource.url)
    }
}
