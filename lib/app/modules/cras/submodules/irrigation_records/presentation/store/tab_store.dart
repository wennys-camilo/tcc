import 'package:flutter/cupertino.dart';

class TabStore {
  ValueNotifier<int> selectedTab = ValueNotifier<int>(0);

  void onChangeTab(int index) {
    selectedTab.value = index;
  }
}
