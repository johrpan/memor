import 'package:flutter/material.dart';

import 'backend.dart';
import 'date_utils.dart';
import 'localizations.dart';
import 'memo.dart';
import 'memo_editor.dart';

/// The Memor home screen.
///
/// The screen shows nothing more than a list of scheduled memos. They can be
/// dismissed by swiping and edited by tapping.
class HomeScreen extends StatelessWidget {
  Future<Memo> _showMemoEditor(BuildContext context, [Memo memo]) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MemoEditor(
          memo: memo,
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final backend = MemorBackend.of(context);
    final l10n = MemorLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.title),
      ),
      body: backend.loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : StreamBuilder<List<Memo>>(
              stream: backend.memos,
              builder: (context, snapshot) {
                final scaffold = Scaffold.of(context);

                if (snapshot.hasData) {
                  final memos = snapshot.data;
                  final now = DateTime.now();

                  if (memos.isNotEmpty) {
                    return ListView.builder(
                      itemCount: memos.length,
                      itemBuilder: (context, index) {
                        final memo = memos[index];
                        final scheduled = memo.scheduled;
                        final isPast = scheduled.compareTo(now) <= 0;
                        final dateString = scheduled.dateString(context);
                        final timeOfDayString =
                            scheduled.timeOfDay.format(context);

                        return Dismissible(
                          key: ValueKey(memo.id),
                          secondaryBackground: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.centerRight,
                            color: Colors.amber,
                            child: const Icon(Icons.done),
                          ),
                          background: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.centerLeft,
                            color: Colors.amber,
                            child: const Icon(Icons.done),
                          ),
                          child: ListTile(
                            title: Text(memo.text),
                            subtitle: Text(
                              l10n.scheduled(dateString, timeOfDayString),
                              style: TextStyle(
                                color: isPast ? Colors.red : null,
                              ),
                            ),
                            onTap: () async {
                              final result =
                                  await _showMemoEditor(context, memo);
                              if (result != null) {
                                await backend.updateMemo(index, result);
                              }
                            },
                          ),
                          onDismissed: (_) async {
                            await backend.deleteMemo(index);
                            scaffold.showSnackBar(
                              SnackBar(
                                content: Text(l10n.deleted(memo.text)),
                                action: SnackBarAction(
                                  label: l10n.undo,
                                  onPressed: () async {
                                    await backend.addMemo(memo);
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text(
                        l10n.noReminders,
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    );
                  }
                } else {
                  return Container();
                }
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await _showMemoEditor(context);
          if (result != null) {
            await backend.addMemo(result);
          }
        },
      ),
    );
  }
}
