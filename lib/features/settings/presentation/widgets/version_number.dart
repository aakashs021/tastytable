import 'package:flutter/material.dart';
import 'package:tastytable/features/settings/presentation/widgets/settings_text.dart';

Widget versionNumber() {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [SettingsText(title: 'Version'), SettingsText(title: '1.0.0')],
    ),
  );
}