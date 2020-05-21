import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Utilities for handling DateTime objects.
extension DateUtils on DateTime {
  /// Create a new instance with identical values.
  DateTime copy() => DateTime(
        this.year,
        this.month,
        this.day,
        this.hour,
        this.minute,
      );

  /// Create a new instance with the same date but a different time.
  DateTime copyWithTime(TimeOfDay time) => DateTime(
        this.year,
        this.month,
        this.day,
        time.hour,
        time.minute,
      );

  /// Get a string representation of the represented day suitable for display.
  String get dateString {
    final now = DateTime.now();
    if (this.year == now.year && this.month == now.month) {
      if (this.day == now.day) {
        return 'Today';
      } else if (this.day == now.day + 1) {
        return 'Tomorrow';
      }
    }

    final format = DateFormat.yMd();
    return format.format(this);
  }

  /// Get the time of day represented by this object.
  TimeOfDay get timeOfDay => TimeOfDay.fromDateTime(this);
}
