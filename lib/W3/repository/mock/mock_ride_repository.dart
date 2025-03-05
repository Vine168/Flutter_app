import '../../model/ride/locations.dart';
import '../../model/ride/ride.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../model/user/user.dart';
import '../../repository/ride_repository.dart';
import '../../service/rides_service.dart';

class MockRidesRepository extends RidesRepository {
  @override
  List<Ride> getRides(RidePref preference, RidesFilter? filter) {
    // Mock users
    User kannika = User(
      firstName: "Kannika",
      lastName: "Kak",
      email: "kannika@example.com",
      phone: "+85512345678",
      profilePicture: "https://example.com/profiles/kannika.jpg",
      verifiedProfile: true,
    );

    User chaylim = User(
      firstName: "Chaylim",
      lastName: "Cheng",
      email: "chaylim@example.com",
      phone: "+85512345678",
      profilePicture: "https://example.com/profiles/chaylim.jpg",
      verifiedProfile: true,
    );

    User mengtech = User(
      firstName: "Mengtech",
      lastName: "Hout",
      email: "mengtech@example.com",
      phone: "+85512345678",
      profilePicture: "https://example.com/profiles/mengtech.jpg",
      verifiedProfile: false,
    );

    User limhao = User(
      firstName: "Limhao",
      lastName: "Chim",
      email: "limhao@example.com",
      phone: "+85512345678",
      profilePicture: "https://example.com/profiles/limhao.jpg",
      verifiedProfile: true,
    );

    User sovanda = User(
      firstName: "Sovanda",
      lastName: "Ban",
      email: "sovanda@example.com",
      phone: "+85511223344",
      profilePicture: "https://example.com/profiles/sovanda.jpg",
      verifiedProfile: false,
    );


    // Mock data for rides
    List<Ride> rides = [
      Ride (
        departureLocation:
        Location(name: "Battambang", country: Country.cambodia),
        arrivalLocation: Location(name: "Siem Reap", country: Country.cambodia),
        departureDate: DateTime.now().add(Duration(hours: 5, minutes: 30)),
        arrivalDateTime: DateTime.now().add(Duration(hours: 8, minutes: 30)),
        driver: kannika,
        availableSeats: 2,
        pricePerSeat: 10.0,
        acceptPets: false,
      ),
      Ride(
        departureLocation:
        Location(name: "Battambang", country: Country.cambodia),
        arrivalLocation: Location(name: "Siem Reap", country: Country.cambodia),
        departureDate: DateTime.now().add(Duration(hours: 8)),
        arrivalDateTime: DateTime.now().add(Duration(hours: 10)),
        driver: chaylim,
        availableSeats: 0,
        pricePerSeat: 12.0,
        acceptPets:false,
      ),
      Ride(
        departureLocation:
        Location(name: "Battambang", country: Country.cambodia),
        arrivalLocation: Location(name: "Siem Reap", country: Country.cambodia),
        departureDate: DateTime.now().add(Duration(hours: 5)),
        arrivalDateTime: DateTime.now().add(Duration(hours: 8)),
        driver: mengtech,
        availableSeats: 1,
        pricePerSeat: 8.0,
        acceptPets: false,
      ),
      Ride(
        departureLocation:
        Location(name: "Battambang", country: Country.cambodia),
        arrivalLocation: Location(name: "Siem Reap", country: Country.cambodia),
        departureDate: DateTime.now().add(Duration(hours: 8)),
        arrivalDateTime: DateTime.now().add(Duration(hours: 10)),
        driver: limhao,
        availableSeats: 2,
        pricePerSeat: 15.0,
        acceptPets: true,
      ),
      Ride(
        departureLocation:
        Location(name: "Battambang", country: Country.cambodia),
        arrivalLocation: Location(name: "Siem Reap", country: Country.cambodia),
        departureDate: DateTime.now().add(Duration(hours: 5)),
        arrivalDateTime: DateTime.now().add(Duration(hours: 8)),
        driver: sovanda,
        availableSeats: 1,
        pricePerSeat: 9.0,
        acceptPets: false,
      ),
      Ride(
        departureLocation:
        Location(name: "Battambang", country: Country.cambodia),
        arrivalLocation: Location(name: "Phnom Penh", country: Country.cambodia),
        departureDate: DateTime.now().add(Duration(hours: 5)),
        arrivalDateTime: DateTime.now().add(Duration(hours: 8)),
        driver: sovanda,
        availableSeats: 1,
        pricePerSeat: 9.0,
        acceptPets: false,
      ),
    ];

    // Filter the rides based on the preferences and filters
    return _getFilteredRides(rides, preference, filter);
  }
  List<Ride> _getFilteredRides(List<Ride> rides, RidePref preference, RidesFilter? filter) {
  return rides.where((ride) {
    bool isValidLocation = _checkLocation(ride, preference);
    bool isValidDate = _checkDate(ride, preference);
    bool isValidPetPreference = _checkPetPreference(ride, filter);

      // All conditions must be true
      return isValidLocation && isValidDate && isValidPetPreference;
    }).toList();
  }

  // Check if the ride matches the location preference
  bool _checkLocation(Ride ride, RidePref preference) {
    return ride.departureLocation == preference.departure && ride.arrivalLocation == preference.arrival;
  }
  bool _checkDate(Ride ride, RidePref preference) {
    return _compareDate(ride.departureDate, preference.departureDate);
  }

  // Check if the ride matches the pet preference from filter
  bool _checkPetPreference(Ride ride, RidesFilter? filter) {
    if (filter == null) return true; // If no filter, all rides are valid
    return ride.acceptPets == filter.acceptPets;
  }

  // Utility method to compare year, month, and day of two DateTime objects
  bool _compareDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
