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
  const TextInputWidget({
    Key? key,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initalValue,
      enabled: enabled,
      controller: controller,
      textAlign: TextAlign.center,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        enabledBorder:
            const OutlineInputBorder(borderSide: BorderSide(width: 0)),
        fillColor: readOnly ? Colors.grey.withOpacity(0.5) : Colors.white,
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
    );
  }
}
