import 'package:flutter/material.dart';

class CButton extends StatelessWidget {

  @required
  final Widget child;
  final double? borderRadius;
  final double? elevation;
  final Color? color;
  final Color? splashColor;
  final EdgeInsets? padding;
  final void Function()? onTapHandler;
  final Color? disableColor;


  CButton({this.disableColor, this.color, this.splashColor, this.padding, this.borderRadius, required this.child, this.elevation, this.onTapHandler});
  @override
  Widget build(BuildContext context) {

    return  Material(

      borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 24)),
      elevation: elevation ?? 2,
      color: onTapHandler == null ? (disableColor ?? Colors.grey) : (color ?? Colors.lightGreen),
      child: InkWell(
        splashColor: splashColor ?? Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 2424)),

        onTap: onTapHandler,
        child: Padding(
          padding: padding ?? EdgeInsets.all(7),
          child: Align(
              alignment: Alignment.center,
              child: child),
        ),
      ),
    );
  }
}