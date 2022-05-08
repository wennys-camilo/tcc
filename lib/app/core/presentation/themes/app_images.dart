abstract class AppImages {
  String get logo;
}

class AppImagesImpl implements AppImages {
  @override
  String get logo => "assets/images/watering-plants.png";
}
