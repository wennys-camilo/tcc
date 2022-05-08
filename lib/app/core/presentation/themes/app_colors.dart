import 'package:flutter/cupertino.dart';

abstract class AppColors {
  Color get primary;
  Color get red;
  Color get white;
  Color get secondary;
  Color get greyLight;
}

class AppColorsImpl implements AppColors {
  @override
  Color get primary => const Color(0xff029676);

  @override
  Color get red => const Color.fromARGB(255, 255, 0, 0);

  @override
  Color get white => const Color.fromARGB(255, 255, 255, 255);

  @override
  Color get secondary => const Color(0xff549e39);

  @override
  Color get greyLight => const Color(0xffeaeaea);
}
