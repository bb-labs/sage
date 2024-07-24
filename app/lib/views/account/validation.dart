import 'package:app/grpc/client.dart';
import 'package:app/models/user.dart';
import 'package:app/proto/sage.pb.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SageAccountValidationButtons extends StatelessWidget {
  final bool validIf;
  const SageAccountValidationButtons({super.key, required this.validIf});

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);

    return Padding(
      padding: const EdgeInsets.all(50),
      child: Row(
        children: [
          const Spacer(),
          ElevatedButton(
            style: ButtonStyle(
              shape: WidgetStateProperty.all(const CircleBorder()),
              padding: WidgetStateProperty.all(const EdgeInsets.all(20)),
              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (validIf) {
                    return ThemeData().colorScheme.onPrimary;
                  }
                  return ThemeData().colorScheme.outlineVariant;
                },
              ),
            ),
            onPressed: () async {
              if (!validIf) return;
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
