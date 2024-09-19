import 'package:flutter/material.dart';
import 'package:reel_news/widgets/AppBar_Widget.dart';
import 'package:reel_news/widgets/BottomTabbar_Widget.dart';
import 'package:url_launcher/url_launcher.dart'; // Needed to open the GitHub link

class CommonScreenUI extends StatelessWidget {
  final String title;
  final Widget body;

  CommonScreenUI({
    required this.title,
    required this.body,
  });

  // Function to launch the GitHub link using Uri
  Future<void> _launchGitHub() async {
    final Uri url = Uri.parse('https://github.com/User5678953/Reelnews_Frontend');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Column(
        children: [
          Expanded(child: body), // The main body of the screen
          Container(
            color: Colors.transparent, // Make the container background transparent
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: _launchGitHub, // Tap on the footer to open GitHub
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.link, color: Colors.blue), // Adding a link icon
                  SizedBox(width: 8), // Spacing between icon and text
                  Text(
                    '2024 WebbyWebDev || Flutter Demo News App',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue, // Link color
                      fontWeight: FontWeight.bold, // Make the link text bold
                      decoration: TextDecoration.underline, // Underline for link effect
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomTabbarWidget(),
    );
  }
}
