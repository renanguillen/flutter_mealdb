import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/recipe_controller.dart';
import 'recipe_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Recipes'),
      ),
      body: Consumer<RecipeController>(
        builder: (context, controller, child) {
          if (controller.favorites.isEmpty) {
            return const Center(
              child: Text('No favorite recipes yet!'),
            );
          }
          return ListView.builder(
            itemCount: controller.favorites.length,
            itemBuilder: (context, index) {
              final recipe = controller.favorites[index];
              return ListTile(
                leading: Image.network(
                  recipe.thumbUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(recipe.name),
                subtitle: Text(recipe.category),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onPressed: () => controller.toggleFavorite(recipe.id),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeDetailScreen(recipe: recipe),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}