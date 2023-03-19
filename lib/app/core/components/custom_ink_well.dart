import 'dart:async';

import 'package:flutter/material.dart';

class CustomInkWell extends StatelessWidget {
  final Widget? child;
  final Function? onTap;
  final BorderRadiusGeometry? shape;
  final int acceptTime;
  bool acceptClick = true;
  String id;

  CustomInkWell({
    Key? key,
    this.child,
    this.onTap,
    this.shape,
    this.acceptTime = 1500,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Semantics(
      label: id,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: shape as BorderRadius?,
          onTap: () {
            if (acceptClick) {
              acceptClick = false;
              if (onTap != null) {
                Timer(const Duration(milliseconds: 100), () {
                  onTap!();
                });
              }
              Timer(Duration(milliseconds: acceptTime), () {
                acceptClick = true;
              });
            }
          },
          child: child,
        ),
      ),
    );
  }
}
