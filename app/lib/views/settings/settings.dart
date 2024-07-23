import 'package:app/models/user.dart';
import 'package:app/views/settings/display.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SageSettings extends StatelessWidget {
  const SageSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Account',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            context.go('/home');
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SageFieldDisplay(
              label: "Name",
              value: userModel.name,
            ),
            SageFieldDisplay(
              label: "Birthday",
              value: DateFormat('MMMM d, y').format(userModel.birthday),
            ),
            SageFieldDisplay(
              label: "Preferences",
              value: userModel.preferencesString,
            ),
            SageFieldDisplay(
              label: "Location",
              value: userModel.locationString,
            )
          ],
        ),
      ),
    );
  }
}
