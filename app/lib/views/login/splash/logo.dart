import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SageLoginLogo extends StatelessWidget {
  const SageLoginLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text("Sage", style: GoogleFonts.cedarvilleCursive(fontSize: 85)),
      const SizedBox(height: 15),
      const Text("Keep the Ghosts Away", style: TextStyle(fontSize: 15))
    ]);
  }
}
