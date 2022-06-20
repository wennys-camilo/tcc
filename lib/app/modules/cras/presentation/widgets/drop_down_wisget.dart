import 'package:flutter/material.dart';

import '../../../../core/presentation/themes/app_theme.dart';

class DropDownWidget<T> extends StatelessWidget {
  final void Function(T?)? onChanged;
  final List<DropdownMenuItem<T>>? items;
  final String? labelText;
  final T? value;
  final TextStyle? style;
  final String? suffixText;
  const DropDownWidget({
    Key? key,
    required this.onChanged,
    required this.items,
    this.labelText,
    this.value,
    this.style,
    this.suffixText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      isExpanded: true,
      value: value,
      decoration: InputDecoration(
        suffixText: suffixText,
        filled: true,
        fillColor: AppTheme.colors.white,
        labelText: labelText,
        border: const OutlineInputBorder(),
        enabledBorder:
            const OutlineInputBorder(borderSide: BorderSide(width: 0)),
        focusedBorder:
            const OutlineInputBorder(borderSide: BorderSide(width: 0)),
        isDense: true,
      ),
      onChanged: onChanged,
      items: items,
      style: style,
    );
  }
}
