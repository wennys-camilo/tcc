import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:tcc/app/core/presentation/widgets/drawer_item_tile_widget.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey.withOpacity(0.2),
        child: NavigationListener(builder: (context, widgets) {
          return ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              DrawerItemTileWidget(
                title: 'CURVA DE RETENÇÃO DE ÁGUA DO SOLO',
                icon: Icons.water,
                selected: Modular.to.path.endsWith('/cras'),
                onTap: () {
                  Modular.to.navigate('/cras');
                },
              ),
              DrawerItemTileWidget(
                title: 'EQUAÇÃO DA CRAS/TENSIÔMETRO',
                icon: Icons.water,
                selected:
                    Modular.to.path.endsWith('/cras-equation-tensiometer/'),
                onTap: () {
                  Modular.to.navigate('/cras-equation-tensiometer/');
                },
              ),
              DrawerItemTileWidget(
                title: 'DADOS DO SOLO',
                icon: Icons.water,
                selected: Modular.to.path.endsWith('/soil-data/'),
                onTap: () {
                  Modular.to.navigate('/soil-data/');
                },
              ),
              DrawerItemTileWidget(
                title: 'DADOS DA CULTURA E DO SISTEMA DE IRRIGAÇÃO',
                icon: Icons.water,
                selected:
                    Modular.to.path.endsWith('/culture-irrigation-system/'),
                onTap: () {
                  Modular.to.navigate('/culture-irrigation-system/');
                },
              ),
              DrawerItemTileWidget(
                title: 'MAJEJO DA IRRIGAÇÃO COM TENSIÔMETRO',
                icon: Icons.water,
                selected: Modular.to.path.endsWith('/irrigation-management/'),
                onTap: () {
                  Modular.to.navigate('/irrigation-management/');
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
