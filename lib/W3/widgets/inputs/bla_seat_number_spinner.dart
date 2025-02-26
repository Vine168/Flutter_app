import 'package:flutter/material.dart';

class BlaSeatNumberSpinner extends StatefulWidget {
  final int initialSeats;
  final Function(int) onChanged;

  const BlaSeatNumberSpinner({
    Key? key,
    this.initialSeats = 1,
    required this.onChanged,
  }) : super(key: key);

  @override
  _BlaSeatNumberSpinnerState createState() => _BlaSeatNumberSpinnerState();
}

class _BlaSeatNumberSpinnerState extends State<BlaSeatNumberSpinner> {
  late int _seatCount;

  @override
  void initState() {
    super.initState();
    _seatCount = widget.initialSeats;
  }

  void _increaseSeats() {
    setState(() {
      _seatCount++;
      widget.onChanged(_seatCount);
    });
  }

  void _decreaseSeats() {
    if (_seatCount > 1) {
      setState(() {
        _seatCount--;
        widget.onChanged(_seatCount);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: _decreaseSeats,
        ),
        Text(
          '$_seatCount',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: _increaseSeats,
        ),
      ],
    );
  }
}