import 'package:tcc/app/core/presentation/themes/app_colors.dart';
import 'package:tcc/app/core/presentation/themes/app_images.dart';

class AppTheme {
  AppTheme._();
  static AppColors get colors => AppColorsImpl();
  static AppImages get images => AppImagesImpl();
}
