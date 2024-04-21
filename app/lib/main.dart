import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text("Sage",
                    style: GoogleFonts.cedarvilleCursive(fontSize: 85)),
                const SizedBox(height: 15),
                const Text("Keep the Ghosts Away",
                    style: TextStyle(fontSize: 15)),
                const Spacer(),
                const Spacer(),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      height: 120,
                      child: OverflowBox(
                        minHeight: 700,
                        maxHeight: 700,
                        child: Lottie.asset(
                          "assets/sage.json",
                          frameRate: FrameRate.max,
                          reverse: true,
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Lottie.asset(
                          "assets/ghost.json",
                          frameRate: FrameRate.max,
                        )),
                  ],
                ),
                const Spacer(),
                const Spacer(),
                const Spacer(),
                const Spacer(),
                const Spacer(),
                SignInButton(
                  Buttons.Google,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 75, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  onPressed: () {
                    print("Sign in with Google");
                  },
                ),
                const SizedBox(height: 15),
                SignInButton(
                  Buttons.Apple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 75, vertical: 17),
                  onPressed: () async {
                    final credential =
                        await SignInWithApple.getAppleIDCredential(
                      scopes: [
                        AppleIDAuthorizationScopes.email,
                        AppleIDAuthorizationScopes.fullName,
                      ],
                    );
                    print(credential);
                  },
                ),
                const SizedBox(height: 15),
                SignInButton(
                  Buttons.Facebook,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 75, vertical: 17),
                  onPressed: () {
                    print("Sign in with Facebook");
                  },
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 11),
                      ),
                      onPressed: () {},
                      child: const Text('Terms of Service'),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 11),
                      ),
                      onPressed: () {},
                      child: const Text('Privacy Policy'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
