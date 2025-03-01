///
/// Enumeration of supported countries.
///
enum Country {
  france('France'),
  uk('United Kingdom'),
  spain('Spain');

  final String displayName;

  const Country(this.displayName);
}

///
/// Represents a geographical location.
///
class Location {
  final String cityName;
  final Country country;

  const Location({required this.cityName, required this.country});
  Location.copy(Location other)
      : cityName = other.cityName,
        country = other.country;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Location && other.cityName == cityName && other.country == country;
  }
  @override
  int get hashCode => cityName.hashCode ^ country.hashCode;
  @override
  String toString() => cityName;
}
///
/// Represents a street within a location.
///
class Street {
  final String streetName;
  final Location location;
  const Street({required this.streetName, required this.location});
}
