import 'package:flutter/material.dart';

import 'localizations.dart';
import 'memo.dart';
import 'date_utils.dart';

/// A screen for editing or creating a memo.
/// 
/// The new memo will be returned when popping the navigator. A return value of
/// null indicates that the user has canceled the editor.
class MemoEditor extends StatefulWidget {
  /// The memo to edit.
  /// 
  /// A value of null indicates that the user will be creating a new memo.
  final Memo memo;

  MemoEditor({
    this.memo,
  });

  @override
  _MemoEditorState createState() => _MemoEditorState();
}

class _MemoEditorState extends State<MemoEditor> {
  final _textController = TextEditingController();

  DateTime _date;
  TimeOfDay _time;

  @override
  void initState() {
    super.initState();

    if (widget.memo != null) {
      _textController.text = widget.memo.text;
      _date = widget.memo.scheduled.copy();
      _time = TimeOfDay.fromDateTime(_date);
    } else {
      _date = DateTime.now().add(Duration(days: 1));
      _time = TimeOfDay(
        hour: 8,
        minute: 0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = MemorLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.memo != null ? l10n.editTitle : l10n.addTitle),
        actions: <Widget>[
          FlatButton(
            child: Text(
              widget.memo != null ? l10n.save : l10n.create,
              style: theme.textTheme.button.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
            onPressed: () {
              Navigator.pop(
                context,
                Memo(
                  text: _textController.text,
                  scheduled: _date.copyWithTime(_time),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _textController,
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: l10n.memo,
              ),
            ),
          ),
          ListTile(
            title: Text(l10n.date),
            subtitle: Text(_date.dateString(context)),
            onTap: () async {
              final result = await showDatePicker(
                context: context,
                initialDate: _date,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 3560)),
              );

              if (result != null) {
                setState(() {
                  _date = result;
                });
              }
            },
          ),
          ListTile(
            title: Text(l10n.time),
            subtitle: Text(_time.format(context)),
            onTap: () async {
              final result = await showTimePicker(
                context: context,
                initialTime: _time,
              );

              if (result != null) {
                setState(() {
                  _time = result;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
