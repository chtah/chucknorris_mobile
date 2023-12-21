import 'package:flutter/material.dart';

class RotateImage extends StatefulWidget {
  const RotateImage({super.key});
  @override
  State<RotateImage> createState() {
    return _RotateImage();
  }
}

class _RotateImage extends State<RotateImage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    animation = Tween<double>(begin: -0.015, end: 0.015).animate(controller);

    controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Center(
        child: RotationTransition(
          turns: animation,
          child: Image.asset(
            'assets/images/chucknorris_logo.png',
            width: 150,
            height: 150,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
