import 'package:flutter/material.dart';
import 'package:reel_news/utility/user_source_subscribed_list.dart';

class SubscriptionToggleHandler extends StatelessWidget {
  final String sourceName;
  final bool isSubscribed;
  final ValueChanged<bool> onToggle;

  const SubscriptionToggleHandler({
    Key? key,
    required this.sourceName,
    required this.isSubscribed,
    required this.onToggle,
  }) : super(key: key);

  Future<void> _handleToggle(bool newValue) async {
    onToggle(newValue);

    List<String> subscribedSources =
        UserSourceSubScribedList.getSelectedSources();
    if (newValue) {
      if (!subscribedSources.contains(sourceName)) {
        subscribedSources.add(sourceName);
      }
    } else {
      subscribedSources.remove(sourceName);
    }

    await UserSourceSubScribedList.setSelectedSources(subscribedSources);
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.2, 
      child: Switch(
        value: isSubscribed,
        onChanged: _handleToggle,
        activeTrackColor:
            Colors.greenAccent.shade700, 
        inactiveTrackColor:
            Colors.red.shade100, 
        activeColor: Colors.green, 
        inactiveThumbColor: Colors.red, 
        splashRadius:
            30, 
        materialTapTargetSize: MaterialTapTargetSize
            .shrinkWrap, 
      ),
    );
  }
}
