import 'package:flutter/material.dart';
import 'package:reel_news/screens/category_views/general_screen.dart';
import 'package:reel_news/screens/category_views/world_screen.dart';
import 'package:reel_news/screens/category_views/nation_screen.dart';
import 'package:reel_news/screens/category_views/business_screen.dart';
import 'package:reel_news/screens/category_views/technology_screen.dart';
import 'package:reel_news/screens/category_views/entertainment_screen.dart';
import 'package:reel_news/screens/category_views/sports_screen.dart';
import 'package:reel_news/screens/category_views/science_screen.dart';
import 'package:reel_news/screens/category_views/health_screen.dart';
import 'package:reel_news/screens/initial_news_screen.dart';
import 'package:reel_news/screens/tabBar_views/my_archive_screen.dart';
import 'package:reel_news/screens/tabBar_views/my_news_screen.dart';
import 'package:reel_news/screens/tabBar_views/my_sources_screen.dart';
import 'package:reel_news/utility/user_source_subscribed_list.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async {

   WidgetsFlutterBinding.ensureInitialized();
  await UserSourceSubScribedList.init();

  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reel News',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.black,
      ),
       home: InitialNewsScreen(),
      routes: {
        '/general': (context) => GeneralScreen(),
        '/world': (context) => WorldScreen(),
        '/nation': (context) => NationScreen(),
        '/business': (context) => BusinessScreen(),
        '/technology': (context) => TechnologyScreen(),
        '/entertainment': (context) => EntertainmentScreen(),
        '/sports': (context) => SportsScreen(),
        '/science': (context) => ScienceScreen(),
        '/health': (context) => HealthScreen(),
        '/archive': (context) => ArchiveScreen(),
        '/discover': (context) => MyNewsScreen(),
        '/sources': (context) => SourceNewsScreen(),
        '/initialNews': (context) => InitialNewsScreen(),
      },
    );
  }
}
