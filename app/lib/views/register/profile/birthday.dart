import 'package:app/models/user.dart';
import 'package:app/proto/sage.pb.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:protobuf/protobuf.dart';
import 'package:provider/provider.dart';

class SageWhatIsYourBirthday extends StatelessWidget {
  const SageWhatIsYourBirthday({super.key});

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
                  maximumDate: DateTime.now()
                      .subtract(Duration(days: 365 * 18 + (18 / 4).round())),
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime(
                    userModel.user.hasBirthday()
                        ? userModel.user.birthday.year
                        : 1999,
                    userModel.user.hasBirthday()
                        ? userModel.user.birthday.month
                        : 12,
                    userModel.user.hasBirthday()
                        ? userModel.user.birthday.day
                        : 31,
                  ),
                  onDateTimeChanged: (DateTime newDateTime) {
                    final newUser = userModel.user.deepCopy();
                    newUser.birthday = newUser.hasBirthday()
                        ? newUser.birthday.deepCopy()
                        : Birthday();
                    newUser.birthday.month = newDateTime.month;
                    newUser.birthday.day = newDateTime.day;
                    newUser.birthday.year = newDateTime.year;
                    userModel.user = newUser;
                  },
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
