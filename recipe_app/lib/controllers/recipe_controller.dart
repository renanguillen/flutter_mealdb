import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeController extends ChangeNotifier {
  final List<Recipe> _recipes = [];
  final List<Recipe> _favorites = [];
  bool _isLoading = false;
  String _error = '';

  List<Recipe> get recipes => _recipes;
  List<Recipe> get favorites => _favorites;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchRecipes() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s='),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _recipes.clear();
        _recipes.addAll(
          (data['meals'] as List)
              .map((meal) => Recipe.fromJson(meal))
              .toList()
        );
      } else {
        _error = 'Failed to fetch recipes';
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleFavorite(String recipeId) {
    final recipeIndex = _recipes.indexWhere((recipe) => recipe.id == recipeId);
    if (recipeIndex != -1) {
      _recipes[recipeIndex].isFavorite = !_recipes[recipeIndex].isFavorite;
      
      if (_recipes[recipeIndex].isFavorite) {
        _favorites.add(_recipes[recipeIndex]);
      } else {
        _favorites.removeWhere((recipe) => recipe.id == recipeId);
      }
      
      notifyListeners();
    }
  }
}