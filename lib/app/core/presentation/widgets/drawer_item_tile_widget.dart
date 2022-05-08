import 'package:flutter/material.dart';

import '../themes/app_theme.dart';

class DrawerItemTileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool selected;
  final void Function()? onTap;
  const DrawerItemTileWidget(
      {Key? key,
      required this.icon,
      required this.title,
      required this.selected,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(
            icon,
            color: AppTheme.colors.primary,
          ),
          backgroundColor: AppTheme.colors.white,
        ),
        title: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: selected
                  ? AppTheme.colors.primary
                  : Colors.black.withOpacity(0.7)),
        ),
      ),
    );
  }
}
