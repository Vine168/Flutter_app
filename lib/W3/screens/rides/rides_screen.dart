import 'package:flutter/material.dart';
import '../../screens/ride_pref/widgets/ride_pref_form.dart';
import '../../screens/rides/widgets/ride_pref_bar.dart';
import '../../service/locations_service.dart';
import '../../service/ride_prefs_service.dart';
import '../../model/ride/ride.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../service/rides_service.dart';
import '../../theme/theme.dart';

import 'widgets/rides_tile.dart';

///
///  The Ride Selection screen allow user to select a ride, once ride preferences have been defined.
///  The screen also allow user to re-define the ride preferences and to activate some filters.
///
class RidesScreen extends StatefulWidget {
  const RidesScreen({super.key});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  RidePref currentPreference = RidePrefService.instance.currentPreference!;
  RidesFilter filter = RidesFilter(acceptPets: true);

  // Modified using the instance 
  List<Ride> get matchingRides =>
      RidesService.instance.getRidesFor(currentPreference, filter);

      

  void onBackPressed() {
    Navigator.of(context).pop(); //  Back to the previous view
  }

  void onPreferencePressed() async {
    // Open the RidePrefForm and wait for the user to submit new preferences
    final newPref = await Navigator.of(context).push<RidePref>(
      MaterialPageRoute(
        builder: (context) => RidePrefForm(
          initRidePref:
              currentPreference, // Pass the current preference to the form
          locationsService: LocationsService.instance,
          onSubmit: (RidePref newPreference) {
            // Return the new preference when the user submits the form
            Navigator.of(context).pop(newPreference);
          },
        ),
      ),
    );

    // If the user submitted a new preference, update the state
    if (newPref != null) {
      setState(() {
        currentPreference = newPref; // Update the current preference
      });
    }
  }

  void onFilterPressed() {}

  @override
  Widget build(BuildContext context) {
    print(matchingRides.length);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(
          left: BlaSpacings.m, right: BlaSpacings.m, top: BlaSpacings.s),
      child: Column(
        children: [
          // Top search Search bar
          RidePrefBar(
              ridePreference: currentPreference,
              onBackPressed: onBackPressed,
              onPreferencePressed: onPreferencePressed,
              onFilterPressed: onFilterPressed),

          Expanded(
            child: ListView.builder(
              itemCount: matchingRides.length,
              itemBuilder: (ctx, index) => RideTile(
                ride: matchingRides[index],
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
