import 'package:flutter/material.dart';
import 'package:recipe_app/controller/bookmark_manager.dart';
import 'package:recipe_app/model/recipe_model.dart';

//TODO: GET ALL BOOKMARKED RECIPES
//TODO: DELETE RECIPE

class BookmarkView extends StatelessWidget {
  BookmarkView({Key? key}) : super(key: key);

  final BookmarkManager _bookmarkController = BookmarkManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark'),
      ),
      body: FutureBuilder(
        future: _bookmarkController.getBookmarkedRecipes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          List<RecipeModel> recipeModels = snapshot.data as List<RecipeModel>;
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              RecipeModel recipeModel = recipeModels[index];

              return ListTile(
                leading: Image.network(
                  recipeModel.image,
                  height: 150,
                  width: 150,
                ),
                title: Text(recipeModel.title),
                subtitle: Text(recipeModel.category),
                trailing: IconButton(
                  onPressed: () {
                    _bookmarkController.removeBookmark(recipeModel.id!);
                  },
                  icon: const Icon(Icons.delete),
                  
                ),
              );
            },
            itemCount: recipeModels.length,
          );
        },
      ),
    );
  }
}
