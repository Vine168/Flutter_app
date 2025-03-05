import '../model/ride_pref/ride_pref.dart';
import '../repository/ride_repository.dart';
import '../dummy_data/dummy_data.dart';
import '../model/ride/ride.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {
  static List<Ride> availableRides = fakeRides;

  // Rides so it can access everywhere
  static RidesService? _instance;
  final RidesRepository repository;

  RidesService._internal(this.repository);

  // Initializes the singleton with a repository
  static void initialize(RidesRepository repo) {
    if (_instance == null) {
      _instance = RidesService._internal(repo);
    } else {
      throw Exception("RidesService is initialized.");
    }
  }

  /// Singleton for service access
  static RidesService get instance {
    if (_instance == null) {
      throw Exception(
          "RidesService is not initialized. Call initialize() first.");
    }
    return _instance!;
  }

  ///
  ///  Return the relevant rides, given the passenger preferences
  ///
  List<Ride> getRidesFor(RidePref preferences, RidesFilter? filter) {
    return instance.repository.getRides(preferences, filter);
  }
}

class RidesFilter {
  final bool acceptPets;

  RidesFilter({required this.acceptPets});
}

void main() {
  for (var ride in RidesService.availableRides) {
    print('From: ${ride.departureLocation}');
    print('To: ${ride.arrivalLocation}');
    print('Date: ${ride.departureDate}');
    print('Price: ${ride.pricePerSeat}€');
    print('Driver: ${ride.driver}');
    print('---------------------');
  }
}
