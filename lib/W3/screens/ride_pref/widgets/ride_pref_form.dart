import 'package:flutter/material.dart';
import '../../../screens/ride_pref/widgets/data_select_screen.dart';
import '../../../screens/ride_pref/widgets/ride_pref_input_tile.dart';
import '../../../screens/ride_pref/widgets/seat_select_screen.dart';
import '../../../service/locations_service.dart';
import '../../../utils/date_time_util.dart';
import '../../../widgets/inputs/bla_location_picker.dart';

import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../widgets/display/bla_divider.dart';
import '../../../widgets/actions/bla_button.dart';
//import 'date_picker.dart';
import '../../../theme/theme.dart';
import '../../../utils/animations_util.dart';
//import 'seat_number_spinner.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  final LocationsService locationsService;

  /// Callback triggered when form is submitted
  final Function(RidePref ridePref) onSubmit;

  const RidePrefForm({
    super.key,
    required this.initRidePref,
    required this.locationsService,
    required this.onSubmit,
    RidePref? initialPreference,
  });

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  // Select departure location
  Location? departure;

  // Select departure time
  late DateTime departureDate;

  // Select arrival location
  Location? arrival;

  // Number of Passenger
  late int requestedSeats;

  /// Valid Form when both locations and date are selected
  // bool get _isFormFieldValid => departure != null && arrival != null;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    _initializeFormData();
  }

  // Initialize form fields from provided RidePref or defaults value
  void _initializeFormData() {
    final pref = widget.initRidePref;
    departure = pref?.departure;
    arrival = pref?.arrival;
    departureDate = pref?.departureDate ?? DateTime.now();
    requestedSeats = pref?.requestedSeats ?? 1;
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  // Handle to open LocationSearchScreen with Bottom-to-Top transition
  void onDeparturePressed() async {
    // 1- Select a location
    Location? selectedLocation = await Navigator.of(context).push<Location>(
        AnimationUtils.createBottomToTopRoute(BlaLocationPicker()));

    // 2- Update the from if needed
    if (selectedLocation != null) {
      setState(() {
        departure = selectedLocation;
      });
    }
  }

  // Handle to open LocationSearchScreen with Bottom-to-Top transition
  void onArrivalPressed() async {
    // 1- Select a location
    Location? selectedLocation = await Navigator.of(context).push<Location>(
        AnimationUtils.createBottomToTopRoute(BlaLocationPicker()));

    // 2- Update the from if needed
    if (selectedLocation != null) {
      setState(() {
        arrival = selectedLocation;
      });
    }
  }

  // Handle on Dtte Selection
  void onDatePressed() async {
    final result = await Navigator.of(context).push<DateTime>(
      AnimationUtils.createBottomToTopRoute(
          DateSelectionScreen(initialDate: departureDate)),
    );

    if (result != null) {
      setState(() {
        departureDate = result;
      });
    }
  }

  // Handle on Seat Selection
  void onSeatsPressed() async {
    final result = await Navigator.of(context).push<int>(
      AnimationUtils.createBottomToTopRoute(
          SeatSelectionScreen(initialSeats: requestedSeats)),
    );

    if (result != null) {
      setState(() {
        requestedSeats = result;
      });
    }
  }

  /// Creates and submits a RidePref object when form is valid
  void onSubmit() {
    // 1- Check input validity
    bool hasDeparture = departure != null;
    bool hasArrival = arrival != null;
    bool isValid = hasDeparture && hasArrival;

    if (isValid) {
      // 2 - Create a  new preference
      RidePref newPreference = RidePref(
          departure: departure!,
          departureDate: departureDate,
          arrival: arrival!,
          requestedSeats: requestedSeats);

      // 3 - Callback with the new preference
      widget.onSubmit(newPreference);
    }
  }

  // Switches departure and arrival locations when both already selected
  void onSwappingLocationPressed() {
    setState(() {
      // We switch only if both departure and arrivate are defined
      if (departure != null && arrival != null) {
        setState(() {
          final temp = departure;
          departure = arrival;
          arrival = temp;
        });
      }
    });
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  String get departureLabel =>
      departure != null ? departure!.name : "Leaving from";
  String get arrivalLabel => arrival != null ? arrival!.name : "Going to";

  bool get showDeparturePLaceHolder => departure == null;
  bool get showArrivalPLaceHolder => arrival == null;

  String get dateLabel => DateTimeUtils.formatDateTime(departureDate);
  String get numberLabel => requestedSeats.toString();

  bool get switchVisible => arrival != null && departure != null;

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
            child: Column(
              children: [
                // Departure location field
                RidePrefInputTile(
                    title: departureLabel,
                    onPressed: onDeparturePressed,
                    leftIcon: Icons.radio_button_checked_outlined,
                    isPlaceHolder: showDeparturePLaceHolder,
                    rightIcon: switchVisible ? Icons.swap_vert : null,
                    onRightIconPressed:
                        switchVisible ? onSwappingLocationPressed : null),
                // Arrival location field
                const BlaDivider(),
                // Arrival location field
                RidePrefInputTile(
                  title: arrivalLabel,
                  onPressed: onArrivalPressed,
                  leftIcon: Icons.radio_button_checked_outlined,
                  isPlaceHolder: showArrivalPLaceHolder,
                ),
                const BlaDivider(),
                // Date selection field
                RidePrefInputTile(
                  title: dateLabel,
                  onPressed: onDatePressed,
                  leftIcon: Icons.calendar_month_outlined,
                ),
                const BlaDivider(),
                // Passenger count field
                RidePrefInputTile(
                  title: numberLabel,
                  onPressed: onSeatsPressed,
                  leftIcon: Icons.person_outline,
                ),
              ],
            ),
          ),
          // Submit button
          SizedBox(
            width: double.infinity,
            child: BlaButton(
              label: 'Search',
              onPressed: onSubmit,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(BlaSpacings.radius),
                  bottomRight: Radius.circular(BlaSpacings.radius),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
