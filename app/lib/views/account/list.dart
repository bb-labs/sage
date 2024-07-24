import 'package:app/models/navigation.dart';
import 'package:app/models/user.dart';
import 'package:app/views/account/preview.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SageFieldList extends StatelessWidget {
  const SageFieldList({super.key});

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);
    return Center(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SageFieldPreview(
            label: SettingsScreen.name.name,
            value: userModel.name,
          ),
          SageFieldPreview(
            label: SettingsScreen.birthday.name,
            value: DateFormat('MMMM d, y').format(userModel.birthday),
          ),
          SageFieldPreview(
            label: SettingsScreen.preferences.name,
            value: userModel.preferencesString,
          ),
          SageFieldPreview(
            label: SettingsScreen.location.name,
            value: userModel.locationString,
          )
        ],
      ),
    );
  }
}
