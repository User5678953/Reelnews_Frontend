import 'package:flutter/material.dart';
import 'package:reel_news/utility/user_source_subscribed_list.dart';
import 'package:reel_news/widgets/subscription_toggle_handler.dart';

class NewsSourceTileWithToggle extends StatefulWidget {
  final String sourceName;

  const NewsSourceTileWithToggle({Key? key, required this.sourceName})
      : super(key: key);

  @override
  _NewsSourceTileWithToggleState createState() =>
      _NewsSourceTileWithToggleState();
}

class _NewsSourceTileWithToggleState extends State<NewsSourceTileWithToggle> {
  bool isSubscribed = false;

  @override
  void initState() {
    super.initState();
    _loadInitialSubscriptionStatus();
  }

  void _loadInitialSubscriptionStatus() {
    List<String> subscribedSources =
        UserSourceSubScribedList.getSelectedSources();
    setState(() {
      isSubscribed = subscribedSources.contains(widget.sourceName);
    });
  }

  void _handleToggle(bool value) {
    setState(() {
      isSubscribed = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        title: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 227, 215, 108),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                widget.sourceName,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        trailing: SubscriptionToggleHandler(
          sourceName: widget.sourceName,
          isSubscribed: isSubscribed,
          onToggle: _handleToggle,
        ),
      ),
    );
  }
}
