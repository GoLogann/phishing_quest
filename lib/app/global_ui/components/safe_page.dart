import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SafePage extends StatelessWidget {
  final Widget child;
  final double? heightBlue;
  final double? heightWhite;

  const SafePage({
    required this.child,
    this.heightBlue,
    this.heightWhite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      body: SizedBox(
        height: 1.sh,
        child: Stack(
          children: [
            Container(
              height: heightBlue ?? .5.sh,
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  colors: [
                    Colors.black,
                    Colors.white
                  ],
                  radius: 0.82,
                  stops: [0.6, 1],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(height: heightWhite ?? .5.sh),
            ),
            SafeArea(child: child),
          ],
        ),
      ),
    );
  }
}
