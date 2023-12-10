import 'package:flutter/material.dart';
import 'package:reel_news/screens/tabBar_views/archive_screen.dart';

class CategoryTileWidget extends StatelessWidget {
  final String imageUrl;
  final String categoryName;

  CategoryTileWidget({
    required this.imageUrl,
    required this.categoryName,
  });

  void _handleTap(BuildContext context) {
    // Handle the tap 
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ArchiveScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _handleTap(context); 
      },
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
              image: NetworkImage(imageUrl),
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
                categoryName,
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

