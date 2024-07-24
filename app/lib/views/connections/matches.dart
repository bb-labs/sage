import 'package:app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SageMatches extends StatelessWidget {
  const SageMatches({super.key});

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);

    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;

    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: deviceRatio,
        ),
        itemCount: userModel.matches.length,
        itemBuilder: (BuildContext context, int index) {
          var user = userModel.matches[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: AspectRatio(
              aspectRatio: deviceRatio,
              child: SizedBox(
                height: 200,
                child: Text("${user.name}"),
              ),
            ),
          );
        },
      ),
    );
  }
}
