import 'package:flutter/material.dart';

class SageWhatIsYourName extends StatefulWidget {
  const SageWhatIsYourName({super.key});

  @override
  State<SageWhatIsYourName> createState() => _SageWhatIsYourNameState();
}

class _SageWhatIsYourNameState extends State<SageWhatIsYourName> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
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
              child: const TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                ),
                style: TextStyle(
                  fontSize: 20,
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
