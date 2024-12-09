import 'package:flutter/material.dart';

class DateRangePickerWidget extends StatefulWidget {
  final Function(DateTimeRange?) onDateRangeSelected;

  const DateRangePickerWidget({
    super.key,
    required this.onDateRangeSelected,
  });

  @override
  DateRangePickerWidgetState createState() => DateRangePickerWidgetState();
}

class DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  DateTimeRange? selectedDateRange;

  Future<void> selectDateRange(BuildContext context) async {
    final DateTimeRange? pickedDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: selectedDateRange ??
          DateTimeRange(
            start: DateTime.now(),
            end: DateTime.now(),
          ),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDateRange != null) {
      setState(() {
        selectedDateRange = pickedDateRange;
      });

      widget.onDateRangeSelected(pickedDateRange);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          selectedDateRange == null
              ? "No date range selected"
              : "Selected: ${selectedDateRange!.start.toLocal()} - ${selectedDateRange!.end.toLocal()}",
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => selectDateRange(context),
          child: const Text("Select Date Range"),
        ),
      ],
    );
  }
}
