import 'package:app/models/navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SageFieldPreview extends StatelessWidget {
  final String label;
  final String value;
  const SageFieldPreview({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    var navigationModel = Provider.of<NavigationModel>(context);

    return InkWell(
      onTap: () {
        navigationModel.settingsScreen = SettingsScreen.values
            .firstWhere((element) => element.name == label);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: const Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        height: 75,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
