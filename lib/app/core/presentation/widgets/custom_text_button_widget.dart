import 'package:flutter/material.dart';

class CustomTextButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundcolor;
  final Widget? customBody;
  final double? height;
  final bool enabled;
  const CustomTextButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundcolor,
    this.customBody,
    this.height,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          backgroundColor: enabled
              ? MaterialStateProperty.all<Color>(
                  backgroundcolor ?? const Color(0xff003299),
                )
              : MaterialStateProperty.all<Color>(
                  Colors.grey,
                ),
        ),
        onPressed: enabled ? onPressed : null,
        child: customBody ??
            Text(
              text,
              style: TextStyle(
                  color: enabled ? Colors.white : Colors.grey.shade200),
            ),
      ),
    );
  }
}
