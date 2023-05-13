import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  List<DropdownMenuItem<String>> _timeZoneMenuItems = [
    DropdownMenuItem(
      value: 'Asia/Jakarta',
      child: Text('UTC+7 - WIB'),
    ),
    DropdownMenuItem(
      value: 'Asia/Singapore',
      child: Text('UTC+8 - WITA'),
    ),
    DropdownMenuItem(
      value: 'Asia/Tokyo',
      child: Text('UTC+9 - WIT'),
    ),
  ];
  String _selectedTimeZone = 'Asia/Jakarta';

  @override
  void initState() {
    super.initState();
    // Initialize the time zones
    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Date & Time'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              TableCalendar(
                rowHeight: 30,
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                ),
              ),
              SizedBox(height: 32.0),
              DropdownButton(
                value: _selectedTimeZone,
                items: _timeZoneMenuItems,
                onChanged: (String? value) {
                  setState(() {
                    _selectedTimeZone = value!;
                  });
                },
              ),
              SizedBox(height: 16.0),
              Text(
                _getCurrentTimeInTimeZone(_selectedTimeZone),
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ));
  }

  String _getCurrentTimeInTimeZone(String timeZoneName) {
    tz.TZDateTime now = tz.TZDateTime.now(tz.getLocation(timeZoneName));
    return DateFormat('hh:mm:ss a').format(now);
  }
}
