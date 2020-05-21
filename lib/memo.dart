import 'dart:math';

import 'package:meta/meta.dart';

/// A simple memo.
/// 
/// This is the model to represent Memor's reminders.
class Memo {
  /// An unique ID for the memo.
  /// 
  /// This will be used for scheduling the notification. It will be generated,
  /// if set to null.
  final int id;

  /// The actual memo set by the user.
  final String text;

  /// The date and time for the scheduled notification.
  final DateTime scheduled;

  static final _random = Random();
  static int _generateId() => _random.nextInt(0xFFFFFFF);

  Memo({
    int id,
    @required this.text,
    @required this.scheduled,
  }) : id = id ?? _generateId();

  factory Memo.fromJson(Map<String, dynamic> json) => Memo(
        id: json['id'],
        text: json['text'],
        scheduled: DateTime.parse(json['scheduled']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'scheduled': scheduled.toIso8601String(),
      };
}
