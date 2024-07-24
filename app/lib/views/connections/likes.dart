import 'package:app/models/user.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SageLikes extends StatelessWidget {
  const SageLikes({super.key});

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: userModel.likes.length,
        itemBuilder: (BuildContext context, int index) {
          var user = userModel.likes[index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(400),
                clipBehavior: Clip.hardEdge,
                child: Text("${user.name}"),
              ),
            ),
          );
        },
      ),
    );
  }
}
