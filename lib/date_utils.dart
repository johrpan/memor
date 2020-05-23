import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'localizations.dart';

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

  /// Get a localized string representation of the represented day suitable for
  /// display.
  String dateString(BuildContext context) {
    final l10n = MemorLocalizations.of(context);
    final now = DateTime.now();
    if (this.year == now.year && this.month == now.month) {
      if (this.day == now.day) {
        return l10n.today;
      } else if (this.day == now.day + 1) {
        return l10n.tomorrow;
      }
    }

    final format = DateFormat.yMd(l10n.languageCode);
    return format.format(this);
  }

  /// Get the time of day represented by this object.
  TimeOfDay get timeOfDay => TimeOfDay.fromDateTime(this);
}
