import 'package:minimalist_state_timer_app/services/storage_service/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStorage implements StorageService {
  static const _timeLeftKey = 'timeLeft';

  @override
  Future<int?> getTimeLeft() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_timeLeftKey);
  }

  @override
  Future<void> saveTimeLeft(int seconds) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_timeLeftKey, seconds);
  }
}
