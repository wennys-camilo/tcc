import 'package:flutter/cupertino.dart';

abstract class AppColors {
  Color get primary;
}

class AppColorsImpl implements AppColors {
  @override
  Color get primary => const Color(0xff029676);
}
