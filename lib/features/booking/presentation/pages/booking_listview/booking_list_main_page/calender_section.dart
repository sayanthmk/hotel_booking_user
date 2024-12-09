import 'package:flutter/material.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:intl/intl.dart';

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
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: HotelBookingColors.basictextcolor,
              primary: HotelBookingColors.basictextcolor,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: HotelBookingColors.basictextcolor,
              foregroundColor: Colors.white,
            ),
          ),
          child: child!,
        );
      },
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(
                Icons.calendar_today,
                color: HotelBookingColors.basictextcolor,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Select Date Range',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: HotelBookingColors.basictextcolor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: selectedDateRange == null
                  ? Colors.grey.shade100
                  : Colors.deepPurple.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              selectedDateRange == null
                  ? "No date range selected"
                  : "Selected: ${_formatDate(selectedDateRange!.start)} - ${_formatDate(selectedDateRange!.end)}",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: selectedDateRange == null
                        ? Colors.grey.shade600
                        : HotelBookingColors.basictextcolor,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => selectDateRange(context),
            icon: const Icon(Icons.calendar_month),
            label: const Text('Choose Dates'),
            style: ElevatedButton.styleFrom(
              backgroundColor: HotelBookingColors.basictextcolor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 3,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }
}
