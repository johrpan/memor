import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'backend.dart';
import 'home_screen.dart';
import 'localizations.dart';

/// A simple reminder app.
///
/// This has to be wrapped by a MemorBackend widget.
class MemorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        MemorLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('de'),
      ],
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.amber,
        textSelectionColor: Colors.amber,
        cursorColor: Colors.amber,
        textSelectionHandleColor: Colors.amber,
        colorScheme: ColorScheme.light(
          primary: Colors.black,
          secondary: Colors.amber,
        ),
        fontFamily: 'Libertinus Sans',
      ),
      title: 'Memor',
      builder: (context, child) => MemorBackend(child: child),
      home: HomeScreen(),
    );
  }
}
