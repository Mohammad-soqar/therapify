import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Space extends StatelessWidget {
  final double width;
  final double height;

  const Space(this.width, this.height, {super.key});

  @override
  Widget build(BuildContext context) => SizedBox(width: width.w, height: height.h);
}

class VSpace extends StatelessWidget {
  final double size;

  const VSpace(this.size, {super.key});

  @override
  Widget build(BuildContext context) => Space(0, size);
}

class HSpace extends StatelessWidget {
  final double size;

  const HSpace(this.size, {super.key});

  @override
  Widget build(BuildContext context) => Space(size, 0);
}
