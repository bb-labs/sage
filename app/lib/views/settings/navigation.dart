import 'package:app/grpc/client.dart';
import 'package:app/models/user.dart';
import 'package:app/proto/sage.pb.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SageSettingsNavigationButtons extends StatelessWidget {
  const SageSettingsNavigationButtons({super.key});

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);

    return Padding(
      padding: const EdgeInsets.all(50),
      child: Row(
        children: [
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20),
            ),
            onPressed: () async {
              await SageClientSingleton()
                  .instance
                  .updateUser(UpdateUserRequest(user: userModel.user));
              if (context.mounted) {
                context.go('/settings');
              }
            },
            child: const Icon(
              Icons.check,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
