import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SageRecordButton extends StatefulWidget {
  const SageRecordButton({
    super.key,
    required this.onStartRecording,
    required this.onStopRecording,
    this.size = 150,
  });

  final VoidCallback? onStartRecording;
  final VoidCallback? onStopRecording;
  final double size;

  @override
  State<SageRecordButton> createState() => _RecordButtonState();
}

class _RecordButtonState extends State<SageRecordButton>
    with SingleTickerProviderStateMixin {
  bool isRecording = false;
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTapDown: (_) {
          setState(() {
            isRecording = true;
          });
          widget.onStartRecording?.call();
          _controller.animateTo(1, duration: const Duration(seconds: 10));
        },
        onTapUp: (_) {
          setState(() {
            isRecording = false;
          });
          widget.onStopRecording?.call();
          _controller.animateTo(120);
        },
        child: Lottie.asset(
          "assets/record.json",
          controller: _controller,
          width: widget.size,
          height: widget.size,
          fit: BoxFit.fill,
          repeat: true,
          onLoaded: (composition) {
            _controller.duration = composition.duration;
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
