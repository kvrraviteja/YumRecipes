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
