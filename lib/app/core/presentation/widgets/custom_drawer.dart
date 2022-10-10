import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:tcc/app/core/presentation/widgets/drawer_item_tile_widget.dart';
import 'package:tcc/app/core/presentation/widgets/show_dialog_widget.dart';
import 'package:url_launcher/url_launcher.dart';

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
                title: 'DADOS DA CULTURA',
                icon: Icons.water,
                selected:
                    Modular.to.path.endsWith('/culture-irrigation-system/'),
                onTap: () {
                  Modular.to.navigate('/culture-irrigation-system/');
                },
              ),
              DrawerItemTileWidget(
                title: 'DADOS DO SISTEMA DE IRRIGAÇÃO',
                icon: Icons.water,
                selected: Modular.to.path.endsWith('/system-irrigation/'),
                onTap: () {
                  Modular.to.navigate('/system-irrigation/');
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
              DrawerItemTileWidget(
                title: 'REGISTROS DE IRRIGAÇÃO',
                icon: Icons.list_alt,
                selected: Modular.to.path.endsWith('/registers-irrigation/'),
                onTap: () {
                  Modular.to.navigate('/registers-irrigation/');
                },
              ),
              DrawerItemTileWidget(
                title: 'AVALIE O APLICATIVO',
                icon: Icons.rate_review,
                selected: false,
                onTap: () async {
                  ShowDialogWidget(
                    bodyText:
                        'Clique no botão abaixo para ser direcionado para o formulário',
                    action: _launchUrl,
                    msgAction: 'Avaliar',
                  ).show(context);
                },
              ),
            ],
          );
        }),
      ),
    );
  }

  Future<void> _launchUrl() async {
    final Uri _url = Uri.parse('https://forms.gle/SStMQ4hf5RHgs16B7');
    if (!await launchUrl(
      _url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $_url';
    }
  }
}
