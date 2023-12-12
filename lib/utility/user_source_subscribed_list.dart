import 'package:shared_preferences/shared_preferences.dart';

class UserSourceSubScribedList {
  static SharedPreferences? _preferences;

  static const _keySources = 'selectedSources';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setSelectedSources(List<String> sources) async =>
      await _preferences?.setStringList(_keySources, sources);

  static List<String> getSelectedSources() =>
      _preferences?.getStringList(_keySources) ?? [];
}
