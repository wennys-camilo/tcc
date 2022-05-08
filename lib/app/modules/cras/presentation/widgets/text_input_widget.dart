import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final bool readOnly;
  final bool enabled;
  final TextInputType? keyboardType;
  final bool decimalInput;
  final String? Function(String?)? validator;
  final String? initalValue;
  final String? suffixText;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final bool centerText;
  final Color? fillColor;
  const TextInputWidget(
      {Key? key,
      this.controller,
      this.labelText,
      this.inputFormatters,
      this.onChanged,
      this.readOnly = false,
      this.enabled = true,
      this.keyboardType,
      this.decimalInput = false,
      this.validator,
      this.initalValue,
      this.suffixText,
      this.labelStyle,
      this.style,
      this.centerText = true,
      this.fillColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !enabled,
      child: TextFormField(
        initialValue: initalValue,
        style: style,
        controller: controller,
        textAlign: centerText ? TextAlign.center : TextAlign.start,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          suffixText: suffixText,
          labelStyle: labelStyle,
          border: const OutlineInputBorder(),
          enabledBorder:
              const OutlineInputBorder(borderSide: BorderSide(width: 0)),
          // ignore: prefer_if_null_operators
          fillColor: fillColor != null
              ? fillColor
              : readOnly
                  ? Colors.grey.withOpacity(0.4)
                  : Colors.white,
          labelText: labelText,
          filled: true,
        ),
        inputFormatters: !decimalInput
            ? inputFormatters
            : [
                FilteringTextInputFormatter.allow((RegExp(r'^\d+\.?\d{0,6}'))),
                LengthLimitingTextInputFormatter(7),
              ],
        keyboardType: !decimalInput
            ? keyboardType
            : const TextInputType.numberWithOptions(decimal: true),
        onChanged: onChanged,
        readOnly: readOnly,
        validator: validator,
      ),
    );
  }
}
