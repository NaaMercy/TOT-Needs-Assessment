import 'package:recipe_app/model/recipe_model.dart';
import 'package:recipe_app/service/bookmark_recipe.dart';

class BookmarkManager {
  final BookmarkService _bookmarkService = BookmarkService();

  Future<List<RecipeModel>> getBookmarkedRecipes() async {
    try {
      await _bookmarkService.open();
      var data = await _bookmarkService.getAllRecipe();
      if (data != null) {
        print('All Recipes: $data');
        await _bookmarkService.close();
        return data;
      }
    } catch (e) {
      print('Something went wrong: $e');
    }
    await _bookmarkService.close();
    return [];
  }

  addBookmark(RecipeModel recipeModel) async {
    try {
      await _bookmarkService.open();
      _bookmarkService.insert(recipeModel);
      await getBookmarkedRecipes();
      await _bookmarkService.close();
    } catch (e) {
      print('###: $e');
    }
  }

  removeBookmark(int id) async {
    try {
      await _bookmarkService.open();
      _bookmarkService.delete(id);
      await getBookmarkedRecipes();
      await _bookmarkService.close();
    } catch (e) {
      print('##: $e');
    }
  }
}