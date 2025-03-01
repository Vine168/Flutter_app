import 'package:flutter/material.dart';
import 'package:flutter_app/W3/screens/rides/widgets/ride_pref_bar.dart';

import '../../model/ride/ride.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../service/rides_service.dart';
import '../../theme/theme.dart';
import 'widgets/rides_tile.dart';

///
/// The Ride Selection screen allows users to select a ride once ride preferences have been defined.
/// The screen also allows users to redefine the ride preferences and activate some filters.
///
class RidesScreen extends StatefulWidget {
  final RidePref initialRidePref;

  const RidesScreen({super.key, required this.initialRidePref});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  List<Ride> get matchingRides => RidesService.getRidesFor(widget.initialRidePref);

  void _onRidePrefPressed() {
    // Open a modal to edit the ride preferences
  }

  void _onFilterPressed() {
    // Handle filter press action
    print("Filter button pressed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: BlaSpacings.m,
          right: BlaSpacings.m,
          top: BlaSpacings.s,
        ),
        child: Column(
          children: [
            // Top search bar for ride preferences
            RidePrefBar(
              ridePref: widget.initialRidePref,
              onRidePrefPressed: _onRidePrefPressed,
              onFilterPressed: _onFilterPressed,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: matchingRides.length,
                itemBuilder: (ctx, index) => RideTile(
                  ride: matchingRides[index],
                  onPressed: () {
                    // Handle ride tile press action
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}