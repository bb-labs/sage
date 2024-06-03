import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SageFacebookSignup extends StatelessWidget {
  const SageFacebookSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return SignInButton(
      Buttons.Facebook,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 17),
      onPressed: () {},
    );
  }
}
