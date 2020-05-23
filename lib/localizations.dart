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

  // About screen

  String get about => de ? 'Über Memor' : 'About Memor';
  String get introTitle => de ? 'Einführung' : 'Introduction';
  String get intro => de
      ? 'Memor ist eine Anwendung, die Sie zu bestimmten Zeiten mit einer '
          'Benachrichtigung an etwas erinnern kann. Sie wurde mit dem Ziel '
          'entwickelt möglichst einfach, schlicht und elegant zu sein.'
      : 'Memor is an app for getting reminders at a specified time via a '
          'notification. It was developed with the goal to be as simple and '
          'elegant as possible.';
  String get licenseTitle => de ? 'Lizenz' : 'License';
  String get license1 => '© 2020 Elias Projahn\n\n'
      'This program is free software: you can redistribute it and/or modify it '
      'under the terms of the GNU General Public License as published by the '
      'Free Software Foundation, either version 3 of the License, or (at your '
      'option) any later version.\n\nThis program is distributed in the hope '
      'that it will be useful, but WITHOUT ANY WARRANTY; without even the '
      'implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR '
      'PURPOSE. See the ';
  String get license2 => 'GNU General Public License';
  String get license3 => ' for more details.';
  String get contactTitle => de ? 'Kontakt' : 'Contact';
  String get contact1 => de
      ? 'Für Fragen, Fehlermeldungen, Anregungen etc. können Sie mich gerne '
      : 'Feel free to contact me ';
  String get contact2 => de ? 'per E-Mail' : 'via E-mail';
  String get contact3 => de
      ? ' kontaktieren. Memor ist freie Software. Sie können bei '
      : ' for questions, bug reports, ideas etc. Memor is free software. You '
          'can study the source code and contribute on ';
  String get contact4 => 'GitHub';
  String get contact5 =>
      de ? ' den Quellcode studieren und zur Entwicklung beitragen.' : '.';

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
