import '../model/ride/locations.dart';
import '../repository/locations_repository.dart';


////
///   This service handles:
///   - The list of available rides
///
class LocationsService {
  final LocationsRepository locationsRepository;

  // Location so it can access everywhere
  static LocationsService? _instance;

  LocationsService._internal(this.locationsRepository);



  List<Location> getLocations() {
    return locationsRepository.getLocations();
  }

  // Initializes the singleton with a repository.
  static void initialize(LocationsRepository repo) {
    if (_instance == null) {
      _instance = LocationsService._internal(repo);
    } else {
      throw Exception("LocatonService is initialized.");
    }
  }

  /// Singleton for service access
  static LocationsService get instance {
    if (_instance == null) {
      throw Exception(
          "LocationsService is not initialized. Call initialize() first.");
    }
    return _instance!;
  }
}
