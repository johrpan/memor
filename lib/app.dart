import 'package:flutter/material.dart';

import 'home_screen.dart';

/// A simple reminder app.
///
/// This has to be wrapped by a MemorBackend widget.
class MemorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: HomeScreen(),
    );
  }
}
