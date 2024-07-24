import 'package:app/models/navigation.dart';
import 'package:app/models/user.dart';
import 'package:app/views/account/validation.dart';
import 'package:app/views/fields/birthday.dart';
import 'package:app/views/fields/location.dart';
import 'package:app/views/fields/name.dart';
import 'package:app/views/fields/preferences.dart';
import 'package:app/views/fields/fields.dart';
import 'package:app/views/account/list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SageAccountSettings extends StatelessWidget {
  const SageAccountSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);
    var navigationModel = Provider.of<NavigationModel>(context);

    final eighteenYearsAgoToday =
        DateTime.now().subtract(const Duration(days: 365 * 18 + 5));

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
      body: IndexedStack(
        index: navigationModel.settingsScreen.index,
        children: [
          const SageFieldList(),
          SageFieldEditor(
            validator: SageAccountValidationButtons(
              validIf: userModel.name.isNotEmpty,
            ),
            child: const SageWhatIsYourName(),
          ),
          SageFieldEditor(
            validator: SageAccountValidationButtons(
              validIf: userModel.birthday.isBefore(eighteenYearsAgoToday),
            ),
            child: const SageWhatIsYourBirthday(),
          ),
          SageFieldEditor(
            validator: SageAccountValidationButtons(
              validIf: userModel.gender.isNotEmpty &&
                  userModel.preferredGenders.isNotEmpty,
            ),
            child: const SageWhatAreYourPreferences(),
          ),
          SageFieldEditor(
            overflow: true,
            validator: SageAccountValidationButtons(
              validIf: userModel.preferredLocation != null,
            ),
            child: const SageWhereDoYouWantToDate(),
          ),
        ],
      ),
    );
  }
}
