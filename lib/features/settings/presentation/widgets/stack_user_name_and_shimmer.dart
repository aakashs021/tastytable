
import 'package:flutter/material.dart';
import 'package:tastytable/features/settings/presentation/widgets/settings_user_name_shimmer.dart';
import 'package:tastytable/features/settings/presentation/widgets/settings_user_name_textfeild.dart';

Widget StackedUserNameAndShimmer() {
  return Stack(
    children: [
      SettingsUserNameTextfeild(
        userName: '',
      ),
      SettingsUserNameShimmer()
    ],
  );
}
