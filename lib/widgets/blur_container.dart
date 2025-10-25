import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import '../constants/nav_constants.dart';

class BlurContainer extends StatelessWidget {
  final Widget child;
  final double? borderRadius;
  final double? sigmaX;
  final double? sigmaY;

  const BlurContainer({
    Key? key,
    required this.child,
    this.borderRadius,
    this.sigmaX,
    this.sigmaY,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(borderRadius ?? NavConstants.borderRadius),
        topRight: Radius.circular(borderRadius ?? NavConstants.borderRadius),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: sigmaX ?? NavConstants.blurSigma,
          sigmaY: sigmaY ?? NavConstants.blurSigma,
        ),
        child: child,
      ),
    );
  }
}
