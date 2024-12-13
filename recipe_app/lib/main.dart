import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/recipe_controller.dart';
import 'views/recipe_list_screen.dart';
import 'views/favorites_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RecipeController(),
      child: MaterialApp(
        title: 'Recipe App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const RecipeListScreen(),
          '/favorites': (context) => const FavoritesScreen(),
        },
      ),
    );
  }
}