import 'package:app/models/user.dart';
import 'package:app/views/fields/fields.dart';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SageWhatIsYourBirthday extends StatelessWidget {
  const SageWhatIsYourBirthday({super.key});

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);

    var eighteenYearsAgoToday =
        DateTime.now().subtract(const Duration(days: 365 * 18 + 5));

    return SageField(
      validated: userModel.birthday.isBefore(eighteenYearsAgoToday),
      child: Column(
        children: [
          const Spacer(),
          const Text(
            'I was born on',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: userModel.birthday,
                onDateTimeChanged: (DateTime newDateTime) {
                  userModel.birthday = newDateTime;
                },
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
