import 'package:flutter/material.dart';

class SageFeed extends StatelessWidget {
  const SageFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return Scaffold(
              backgroundColor: Colors.brown.shade100,
              body: Center(
                child: Text('Feed: $index'),
              ),
            );
          case 1:
            return Scaffold(
              backgroundColor: Colors.red.shade200,
              body: Center(
                child: Text('Feed: $index'),
              ),
            );
          case 2:
            return Scaffold(
              backgroundColor: Colors.green.shade300,
              body: Center(
                child: Text('Feed: $index'),
              ),
            );
        }
      },
    );
  }
}
