import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../widgets/actions/bla_button.dart';
import 'package:intl/intl.dart';

class DateSelectionScreen extends StatefulWidget {
  final DateTime initialDate;

  const DateSelectionScreen({
    super.key,
    required this.initialDate,
  });

  @override
  State<DateSelectionScreen> createState() => _DateSelectionScreenState();
}

class _DateSelectionScreenState extends State<DateSelectionScreen> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: BlaColors.neutralLight),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Select date',
          style: BlaTextStyles.body.copyWith(
            color: BlaColors.textNormal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                SizedBox(height: BlaSpacings.xl),
                Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: BlaColors.primary, // Selected date background
                      onPrimary: Colors.white, // Selected date text
                      onSurface: BlaColors.textNormal, // Default text color
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor:
                            BlaColors.primary, // Month/year picker text
                      ),
                    ),
                  ),
                  child: CalendarDatePicker(
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 90)),
                    onDateChanged: (DateTime date) {
                      setState(() {
                        selectedDate = date;
                      });
                    },
                    selectableDayPredicate: (DateTime date) {
                      return date.isAfter(
                          DateTime.now().subtract(const Duration(days: 1)));
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(BlaSpacings.m),
            child: SizedBox(
              width: double.infinity,
              child: BlaButton(
                label: 'Confirm',
                onPressed: () => Navigator.pop(context, selectedDate),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(BlaSpacings.radius),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DateDisplay extends StatelessWidget {
  final DateTime date;
  final bool isToday;

  const DateDisplay({
    super.key,
    required this.date,
    this.isToday = false,
  });

  String _formatDate() {
    if (isToday) return 'Today';

    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    if (date.year == now.year &&
        date.month == now.month &&
        date.day == tomorrow.day) {
      return 'Tomorrow';
    }

    return DateFormat('EEE, MMM d').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatDate(),
      style: BlaTextStyles.body.copyWith(
        color: BlaColors.textNormal,
      ),
    );
  }
}
