import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class MemorLocalizations {
  static const delegate = MemorLocalizationsDelegate();

  static MemorLocalizations of(BuildContext context) =>
      Localizations.of<MemorLocalizations>(context, MemorLocalizations);

  final String languageCode;

  MemorLocalizations(this.languageCode);

  bool get de => languageCode == 'de';

  // Home screen

  String get title => 'Memor';
  String scheduled(String date, String time) =>
      de ? '$date um $time' : '$date at $time';
  String deleted(String msg) => de ? '"$msg" gelöscht' : 'Deleted "$msg"';
  String get undo => de ? 'RÜCKGÄNGIG' : 'UNDO';
  String get noReminders =>
      de ? 'Keine Erinnerungen eingerichtet' : 'No reminders scheduled';

  // Memo editor

  String get editTitle => de ? 'Memo bearbeiten' : 'Edit memo';
  String get addTitle => de ? 'Memo erstellen' : 'Create memo';
  String get save => de ? 'SPEICHERN' : 'SAVE';
  String get create => de ? 'ERSTELLEN' : 'CREATE';
  String get memo => 'Memo';
  String get date => de ? 'Datum' : 'Date';
  String get time => de ? 'Zeit' : 'Time';

  // Backend

  String get notificationDescription =>
      de ? 'Memors Erinnerungen' : 'Memor reminders';
  String get reminder => de ? 'Erinnerung' : 'Reminder';

  // Date utils

  String get today => de ? 'Heute' : 'Today';
  String get tomorrow => de ? 'Morgen' : 'Tomorrow';
}

class MemorLocalizationsDelegate
    extends LocalizationsDelegate<MemorLocalizations> {
  const MemorLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'de'].contains(locale.languageCode);

  @override
  Future<MemorLocalizations> load(Locale locale) {
    return SynchronousFuture<MemorLocalizations>(
        MemorLocalizations(locale.languageCode));
  }

  @override
  bool shouldReload(MemorLocalizationsDelegate old) => false;
}
