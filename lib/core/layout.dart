import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Layout {
  static double getWidth(BuildContext ctx) => MediaQuery.of(ctx).size.width;
  static double getHeight(BuildContext ctx) => MediaQuery.of(ctx).size.height;

  static Orientation getOrientation(BuildContext ctx) =>
      MediaQuery.of(ctx).orientation;

  static gap(double g) => Gap(g);
}
