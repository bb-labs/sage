import 'package:app/models/navigation.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SageKeyboard extends StatelessWidget {
  const SageKeyboard({super.key});

  @override
  Widget build(BuildContext context) {
    var navigationModel = Provider.of<NavigationModel>(context);

    final bottomInset = MediaQuery.of(context).viewInsets.bottom -
        kBottomNavigationBarHeight * 1.75;

    return Visibility(
      visible: navigationModel.reelKeyboardVisible,
      child: Column(
        children: [
          const Spacer(),
          TextFormField(
            autofocus: true,
            maxLines: null,
            textInputAction: TextInputAction.send,
            onEditingComplete: () {
              navigationModel.reelKeyboardVisible = false;
            },
            decoration: InputDecoration(
              filled: true,
              hintText: "Say hi ;)",
              fillColor: Colors.grey[200],
            ),
          ),
          bottomInset > kBottomNavigationBarHeight * 1.75
              ? SizedBox(height: bottomInset)
              : const SizedBox(),
        ],
      ),
    );
  }
}
