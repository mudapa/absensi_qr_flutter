import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final double width;
  final Function() onPressed;
  final EdgeInsets margin;
  final Color? color;
  final Widget? icon;

  const CustomButton({
    Key? key,
    this.title,
    this.width = double.infinity,
    required this.onPressed,
    this.margin = EdgeInsets.zero,
    this.color,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 55,
      margin: margin,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              32,
            ),
          ),
          backgroundColor: color ?? Colors.blueAccent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? const SizedBox(),
            icon != null ? const SizedBox(width: 2) : const SizedBox(),
            Text(
              title ?? '',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
