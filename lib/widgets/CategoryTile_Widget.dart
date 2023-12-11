import 'package:flutter/material.dart';
import 'package:reel_news/models/category_model.dart';

class CategoryTile_Widget extends StatelessWidget {
  final CategoryModel category;

  CategoryTile_Widget({
    required this.category,
  });

  void _navigateToCategoryScreen(BuildContext context) {
    final categoryName = category.categoryName.toLowerCase();

    // Check the category name and navigate to the screen
    switch (categoryName) {
      case 'business':
        Navigator.pushNamed(context, '/business');
        break;
      case 'entertainment':
        Navigator.pushNamed(context, '/entertainment');
        break;
      case 'general':
        Navigator.pushNamed(context, '/general');
        break;
      case 'health':
        Navigator.pushNamed(context, '/health');
        break;
      case 'science':
        Navigator.pushNamed(context, '/science');
        break;
      case 'sports':
        Navigator.pushNamed(context, '/sports');
        break;
      case 'technology':
        Navigator.pushNamed(context, '/technology');
        break;
      case 'world':
        Navigator.pushNamed(context, '/world');
        break;
      case 'nation':
        Navigator.pushNamed(context, '/nation');
        break;
      default:
        // Handle other categories or show a message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Category not supported: ${category.categoryName}'),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToCategoryScreen(context),
      child: Container(
        width: 175,
        height: 450,
        padding: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(category.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                category.categoryName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
