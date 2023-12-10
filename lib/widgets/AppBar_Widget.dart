import 'package:flutter/material.dart';
import 'package:reel_news/screens/initial_news_screen.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onLogout;

  AppBarWidget({required this.onLogout, required Null Function() onMenuTap});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      leading: Container(
        decoration: BoxDecoration(
          color: Colors.blue, 
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.all(8),
        child: Center(
          child: IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => InitialNewsScreen()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ),
      ),
      // title
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Reel',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: Colors.yellow,
            ),
          ),
          Text(
            'News',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(8),
          ),
          margin: EdgeInsets.all(8),
          child: Center(
            child: IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
                size: 24, 
              ),
              onPressed: onLogout,
            ),
          ),
        ),
      ],
      elevation: 4.0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
