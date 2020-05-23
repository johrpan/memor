import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart' as pp;
import 'package:rxdart/rxdart.dart';

import 'localizations.dart';
import 'memo.dart';

/// Widget for managing resources and state for Memor.
///
/// This should be near the top of the widget tree and provide other widgets
/// with the globally shared resources and state.
class MemorBackend extends StatefulWidget {
  /// Retrieve the current backend state.
  static MemorBackendState of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_InheritedMemorBackend>()
      .state;

  /// The next widget down the tree.
  ///
  /// Descendants can get the current state by calling [of].
  final Widget child;

  MemorBackend({
    @required this.child,
  });

  @override
  MemorBackendState createState() => MemorBackendState();
}

class MemorBackendState extends State<MemorBackend> {
  /// This will always contain the current list of memos.
  ///
  /// The memos will be ordered by their scheduled time.
  final memos = BehaviorSubject.seeded(<Memo>[]);

  /// Whether the backend is currently loading.
  ///
  /// If this is true, the UI should not call backend methods.
  bool loading = true;

  static const _fileName = 'memos.json';

  final _notifications = FlutterLocalNotificationsPlugin();
  File _file;

  @override
  void initState() {
    super.initState();
    _load();
  }

  /// Initialize resources and load memos from disk.
  Future<void> _load() async {
    await _notifications.initialize(InitializationSettings(
        AndroidInitializationSettings('ic_memor'),
        IOSInitializationSettings()));

    final _baseDirectory = await pp.getApplicationDocumentsDirectory();
    _file = File(p.join(_baseDirectory.path, _fileName));

    if (await _file.exists()) {
      final contents = await _file.readAsString();
      final List<Map<String, dynamic>> json = List.from(jsonDecode(contents));

      List<Memo> newMemos = [];
      for (final memoJson in json) {
        newMemos.add(Memo.fromJson(memoJson));
      }

      memos.add(newMemos);
    }

    setState(() {
      loading = false;
    });
  }

  /// Save memos to disk.
  Future<void> _save() async {
    final json = memos.value.map((m) => m.toJson()).toList();
    await _file.writeAsString(jsonEncode(json));
  }

  /// Add a memo to the list.
  ///
  /// This will sort the list and update the stream afterwards. A notification
  /// will be scheduled for the new memo.
  Future<void> addMemo(Memo memo) async {
    final List<Memo> newMemos = List.from(memos.value);
    newMemos.add(memo);
    newMemos.sort((m1, m2) => m1.scheduled.compareTo(m2.scheduled));
    memos.add(newMemos);
    await _schedule(memo);
    await _save();
  }

  /// Delete a memo by its index.
  ///
  /// This will update the stream afterwards. The scheduled notification will
  /// be canceled.
  Future<void> deleteMemo(int index) async {
    final List<Memo> newMemos = List.from(memos.value);
    final memo = newMemos.removeAt(index);
    memos.add(newMemos);
    await _notifications.cancel(memo.id);
    await _save();
  }

  /// Replace a memo by its index.
  ///
  /// This will sort the list and update the stream afterwards. The scheduled
  /// notification for the old memo will be canceled and rescheduled.
  Future<void> updateMemo(int index, Memo memo) async {
    final List<Memo> newMemos = List.from(memos.value);
    final oldMemo = newMemos[index];
    await _notifications.cancel(oldMemo.id);
    newMemos[index] = memo;
    newMemos.sort((m1, m2) => m1.scheduled.compareTo(m2.scheduled));
    memos.add(newMemos);
    await _schedule(memo);
    await _save();
  }

  /// Schedule a notification for a memo.
  Future<void> _schedule(Memo memo) async {
    final l10n = MemorLocalizations.of(context);
    _notifications.schedule(
      memo.id,
      l10n.reminder,
      memo.text,
      memo.scheduled,
      NotificationDetails(
        AndroidNotificationDetails(
          'memor',
          'Memor',
          l10n.notificationDescription,
        ),
        IOSNotificationDetails(),
      ),
      androidAllowWhileIdle: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedMemorBackend(
      state: this,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    super.dispose();
    memos.close();
  }
}

/// Helper widget to pass the current backend state down the widget tree.
class _InheritedMemorBackend extends InheritedWidget {
  /// The current backend state.
  final MemorBackendState state;

  /// The next widget down the tree.
  final Widget child;

  _InheritedMemorBackend({
    @required this.state,
    @required this.child,
  });

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
