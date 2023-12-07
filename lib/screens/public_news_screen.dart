import 'package:flutter/material.dart';

class PublicNewsViews extends StatefulWidget {
  const PublicNewsViews({super.key});

  @override
  State<PublicNewsViews> createState() => _PublicNewsViewsState();
}

class _PublicNewsViewsState extends State<PublicNewsViews> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        title: Row(
          
          children: [
            Text("Reel", style: theme.appBarTheme.titleTextStyle),
            Text("News", style: theme.appBarTheme.titleTextStyle),
          ],
        ),
      ),
    );
  }
}
