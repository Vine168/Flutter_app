import 'package:flutter/material.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../theme/theme.dart';
import '../../../utils/date_time_util.dart';
import '../../../model/ride/ride.dart';
import '../../../service/rides_service.dart';
import 'package:intl/intl.dart';

///
/// This tile represents an item in the list of past entered ride inputs
///
class RidePrefHistoryTile extends StatelessWidget {
  final RidePref ridePref;
  final VoidCallback? onPressed;

  const RidePrefHistoryTile({super.key, required this.ridePref, this.onPressed});

  String get title => "${ridePref.departure.name} → ${ridePref.arrival.name}";

  String get subTitle =>
      "${DateTimeUtils.formatDateTime(ridePref.departureDate)},  ${ridePref.requestedSeats} passenger${ridePref.requestedSeats > 1 ? "s" : ""}";

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      title: Text(title, style: BlaTextStyles.body.copyWith(color: BlaColors.textNormal)),
      subtitle: Text(subTitle, style: BlaTextStyles.label.copyWith(color: BlaColors.textLight)),
      leading: Icon(Icons.history, color: BlaColors.iconLight,),
      trailing: Icon(Icons.arrow_forward_ios, color: BlaColors.iconLight, size: 16,),
    );
  }
}

///
/// Display the list of rides available today
///

class AvailableToday extends StatelessWidget {
  const AvailableToday({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    String todayFormatted = DateFormat('yyyy-MM-dd').format(today);

      List<Ride> availableRides = RidesService.availableRides.where((ride) {
        String rideDateFormatted = DateFormat('yyyy-MM-dd').format(ride.departureDate);
        return rideDateFormatted == todayFormatted;
      }).toList();

    return Center(
      child: availableRides.isNotEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: availableRides.map((ride) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${ride.departureLocation.name} → ${ride.arrivalLocation.name}\nDeparture: ${DateFormat('hh:mm a').format(ride.departureDate)}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )).toList(),
            )
          : Text('No rides available today.', style: TextStyle(fontSize: 18)),
    );
  }
} 
  
