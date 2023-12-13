import 'package:shared_preferences/shared_preferences.dart';

class UserSourceSubScribedList {
  static SharedPreferences? _preferences;

  static const _keySources = 'selectedSources';

  // Initialize SharedPreferences when the app starts
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  // Save a list of selected sources to SharedPreferences
  static Future setSelectedSources(List<String> sources) async =>
      await _preferences?.setStringList(_keySources, sources);

  // Retrieve a list of selected sources from SharedPreferences
  static List<String> getSelectedSources() =>
      _preferences?.getStringList(_keySources) ?? [];
}
