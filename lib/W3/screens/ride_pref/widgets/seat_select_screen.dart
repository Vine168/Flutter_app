import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

class SeatSelectionScreen extends StatefulWidget {
  const SeatSelectionScreen({super.key, required int initialSeats});

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  int seats = 1; // Default seat count

  // Increate Number by +1
  void _increaseSeats() {
    setState(() {
      seats++;
    });
  }

  // Decrease Number by -1
  void _decreaseSeats() {
    if (seats > 1) {
      setState(() {
        seats--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BlaColors.white,
      appBar: AppBar(
        backgroundColor: BlaColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.blue, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Text(
            "Number of seats to book",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: BlaColors.neutralDark,
            ),
          ),
          const SizedBox(height: 200),
          // Row for minus button, seat count, and plus button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon:
                    Icon(Icons.remove_circle_outline, color: BlaColors.primary),
                iconSize: 40,
                onPressed: _decreaseSeats,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Text(
                  "$seats",
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline, color: Colors.blue),
                iconSize: 40,
                onPressed: _increaseSeats,
              ),
            ],
          ),

          const SizedBox(height: 60),

          // Confirm Button
          // Confirm Button
          ElevatedButton(
            onPressed: () {
              // Return the selected number of seats
              Navigator.pop(context, seats);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            ),
            child: const Text(
              "Confirm",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
