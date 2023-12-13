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

  // Handle the toggle state change
  Future<void> _handleToggle(bool newValue) async {
    onToggle(newValue); 
    // Notify the parent widget about the state change

    List<String> subscribedSources =
        UserSourceSubScribedList.getSelectedSources();
    if (newValue) {
      if (!subscribedSources.contains(sourceName)) {
        subscribedSources
            .add(sourceName); 
            // Add the source to the list if subscribed
      }
    } else {
      subscribedSources.remove(sourceName); 
      // Remove the source if unsubscribed
    }

    await UserSourceSubScribedList.setSelectedSources(
        subscribedSources); 
        // Save the updated list to SharedPreferences
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.2, 
      child: Switch(
        value: isSubscribed, 
         // Handle toggle changes
        onChanged: _handleToggle, 
        
        activeTrackColor:
            Colors.greenAccent.shade700, 
        inactiveTrackColor: Colors.red.shade100, 
        activeColor: Colors.green, 
        inactiveThumbColor: Colors.red, 
        splashRadius: 30, 
        materialTapTargetSize:
            MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
