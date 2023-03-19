import 'package:flutter/material.dart';

import '../values/app_colors.dart';

abstract class BaseShimmerWidget extends StatelessWidget {
  final Color baseColor = const Color(0xFFE8E8E8);
  final Color highLightColor = white_88;
  final Duration time = const Duration(milliseconds: 750);

  const BaseShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: getBuildWidget(context),
    );
  }

  Widget getBuildWidget(BuildContext context);
}
