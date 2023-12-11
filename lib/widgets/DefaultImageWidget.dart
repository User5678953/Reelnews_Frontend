import 'package:flutter/material.dart';

class DefaultImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  DefaultImage({
    required this.imageUrl,
    this.width = 1200, 
    this.height = 628,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        // If the image fails to load
        return Container(
          width: width,
          height: height,
          color: Colors.grey, // grey box
          child: Center(
            child: Icon(Icons.image,
                size: 50, color: Colors.white), 
          ),
        );
      },
    );
  }
}
