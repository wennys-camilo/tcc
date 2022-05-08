import 'package:flutter/material.dart';

import '../../../../core/presentation/themes/app_theme.dart';

class DropDownWidget extends StatelessWidget {
  final void Function(dynamic)? onChanged;
  final List<DropdownMenuItem<dynamic>>? items;
  final String? labelText;
  final dynamic value;
  final TextStyle? style;
  final String? suffixText;
  const DropDownWidget({
    Key? key,
    required this.onChanged,
    required this.items,
    this.labelText,
    required this.value,
    this.style,
    this.suffixText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<dynamic>(
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
        isDense: true,
      ),
      onChanged: onChanged,
      items: items,
      style: style,
    );
  }
}
