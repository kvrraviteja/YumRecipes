# YumRecipes
YumRecipes app is designed to provide a list of popular recipes.

### Model
RecipeModel - The recipe model capture details of a recipe. `name`, `cuisine`, `photo_url_large`, `photo_url_small`, and `uuid` are mandatory fields.

### Network
RecipeImageLoader - Recipe image loader is responsible to fetch image from remote if the image doesn't exist in local cache.
RecipeImageCache - Caches downloaded images. 
RecipesAPIManager - API manager encapsulates the details of various APIs. In this case, various endpoints for recipes. Interface for the application layer to fetch data.
RecipesNetworkManager - The network manager makes network requests to fetch data and is agnostic of request and response.

### View
ContentView - The content view loads on app launch
RecipeFullscreenImage - Loads the recipe image in full screen, when the recipe thumbnail image is tapped.
RecipeImage - The recipe thumbnail image in the recipes list.
RecipeList - Display list of recipes when available. Show a user friendly message when recipes is empty. Allows searching for recipes by name or cuisine.
RecipeRow - Display the recipe thumbnail image, name and cuisine. 

### ViewModel
RecipesViewModel - Hosts the bussiness logic to fetch and process recipes. 

### Unit tests
RecipeTests - Test image cache and recipes source


![Screenshot 2025-02-27 at 6 37 10 AM](https://github.com/user-attachments/assets/b3501966-0cd0-4753-8d46-ee40afa3847f)
![Screenshot 2025-02-27 at 6 37 00 AM](https://github.com/user-attachments/assets/83718964-9bf6-49d3-9600-a0aa364edffc)
![Screenshot 2025-02-27 at 6 36 45 AM](https://github.com/user-attachments/assets/cd4a13b9-af7e-4272-a58d-0e556a160ec3)
![Screenshot 2025-02-27 at 4 56 19 PM](https://github.com/user-attachments/assets/37860ab3-431e-450e-8f39-296c43ba73d3)



