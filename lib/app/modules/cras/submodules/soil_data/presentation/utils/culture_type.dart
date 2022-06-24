class CultureType {
  String name(String value) {
    if (value == '0') {
      return 'Soja';
    } else if (value == '1') {
      return 'Milho';
    } else if (value == '2') {
      return "Feijão";
    }

    return "";
  }
}
