// Abstract Listener
abstract class RidePreferencesListener {
  void onPreferenceSelected(RidePreference selectedPreference);
}

// RidePreference Model
class RidePreference {
  final String preference;
  RidePreference(this.preference);
}
// RidePreferencesService
class RidePreferencesService {
  final List<RidePreferencesListener> _listeners = [];
  RidePreference? _selectedPreference;

  RidePreference? get selectedPreference => _selectedPreference;
  void addListener(RidePreferencesListener listener) {
    _listeners.add(listener);
  }
  void removeListener(RidePreferencesListener listener) {
    _listeners.remove(listener);
  }
  void _notifyListeners() {
    for (var listener in _listeners) {
      listener.onPreferenceSelected(_selectedPreference!);
    }
  }
  void setSelectedPreference(RidePreference preference) {
    _selectedPreference = preference;
    _notifyListeners();
  }
}

// ConsoleLogger
class ConsoleLogger implements RidePreferencesListener {
  @override
  void onPreferenceSelected(RidePreference selectedPreference) {
    print("Preference changed to: ${selectedPreference.preference}");
  }
}
// test the Implementation
void main() {
  final ridePreferencesService = RidePreferencesService();
  final consoleLogger = ConsoleLogger();

  ridePreferencesService.addListener(consoleLogger);
  ridePreferencesService.setSelectedPreference(RidePreference("Eco Mode"));
  ridePreferencesService.setSelectedPreference(RidePreference("Comfort Mode"));
}