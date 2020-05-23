import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url;

import 'localizations.dart';

class AboutScreen extends StatelessWidget {
  static const _email = 'mailto:johrpan@gmail.com?subject=Memor';
  static const _license = 'https://www.gnu.org/licenses/gpl-3.0.html';
  static const _github = 'https://github.com/johrpan/memor';

  @override
  Widget build(BuildContext context) {
    final l10n = MemorLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.about),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          Text(
            l10n.introTitle,
            style: theme.textTheme.headline6,
          ),
          SizedBox(
            height: 12.0,
          ),
          Text(l10n.intro),
          SizedBox(
            height: 24.0,
          ),
          Text(
            l10n.contactTitle,
            style: theme.textTheme.headline6,
          ),
          SizedBox(
            height: 12.0,
          ),
          RichText(
            text: TextSpan(
              style: theme.textTheme.bodyText1,
              children: [
                TextSpan(
                  text: l10n.contact1,
                ),
                TextSpan(
                  text: l10n.contact2,
                  style: theme.textTheme.bodyText1.copyWith(
                    color: Colors.amber[700],
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => url.launch(_email),
                ),
                TextSpan(
                  text: l10n.contact3,
                ),
                TextSpan(
                  text: l10n.contact4,
                  style: theme.textTheme.bodyText1.copyWith(
                    color: Colors.amber[700],
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => url.launch(_github),
                ),
                TextSpan(
                  text: l10n.contact5,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
          Text(
            l10n.licenseTitle,
            style: theme.textTheme.headline6,
          ),
          SizedBox(
            height: 12.0,
          ),
          RichText(
            text: TextSpan(
              style: theme.textTheme.bodyText1,
              children: [
                TextSpan(
                  text: l10n.license1,
                ),
                TextSpan(
                  text: l10n.license2,
                  style: theme.textTheme.bodyText1.copyWith(
                    color: Colors.amber[700],
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => url.launch(_license),
                ),
                TextSpan(
                  text: l10n.license3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
