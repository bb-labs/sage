import 'package:app/models/user.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SageWhatIsYourName extends StatelessWidget {
  const SageWhatIsYourName({super.key});

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);

    return Column(
      children: [
        const Spacer(),
        const Text(
          'Hi, my name is',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          child: TextFormField(
            initialValue: userModel.name,
            onChanged: (value) {
              userModel.name = value;
            },
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
            ),
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
