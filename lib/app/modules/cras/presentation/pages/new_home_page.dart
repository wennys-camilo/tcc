import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:tcc/app/core/presentation/widgets/custom_drawer.dart';
import 'package:tcc/app/modules/cras/presentation/widgets/item_cras.dart';

import '../../../../core/domain/helpers/errors/failure.dart';
import '../../../../core/presentation/themes/app_theme.dart';
import '../../domain/models/cras_chart.dart';
import '../state/cras_state.dart';
import '../stores/cras_store.dart';

class NewHomePage extends StatefulWidget {
  final CrasStore store;
  const NewHomePage({Key? key, required this.store}) : super(key: key);

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  CrasStore get store => widget.store;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const CustomDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Curva de Retenção de Água do Solo'),
        ),
        body: Container(
          color: AppTheme.colors.primary.withOpacity(0.1),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: FutureBuilder<List<CrasChart>>(
                future: store.fetchList(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return FormField<List<CrasChart>>(
                      initialValue: store.state.chartList,
                      validator: (cras) {
                        if (cras!.isEmpty) return 'Insira um tamanho';
                        return null;
                      },
                      builder: (state) {
                        return state.value!.isNotEmpty
                            ? Center(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: <Widget>[
                                      Icon(
                                        Icons.query_stats_outlined,
                                        size: 80,
                                        color: AppTheme.colors.primary,
                                      ),
                                      Column(
                                          children: List.generate(
                                              state.value!.length, (index) {
                                        return Column(
                                          children: [
                                            ItemCras(
                                              key: ObjectKey(
                                                  state.value![index]),
                                              item: state.value![index],
                                              index: index,
                                            ),
                                          ],
                                        );
                                      })),
                                      if (state.hasError)
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: const Center(
                                            child: Text(
                                              'Informe o Cras',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              )
                            : Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        'Inserir Curva de Retenção de Água do Solo',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: AppTheme.colors.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () =>
                                          Modular.to.navigate('/edit-cras/'),
                                      child: Icon(
                                        Icons.edit_note,
                                        size: 100,
                                        color: AppTheme.colors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        ),
        floatingActionButton: TripleBuilder<CrasStore, Failure, CrasState>(
          store: store,
          builder: (context, triple) {
            if (triple.state.chartList.isNotEmpty) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton.extended(
                    backgroundColor: AppTheme.colors.primary,
                    onPressed: () => Modular.to.navigate('/edit-cras'),
                    label: const Icon(Icons.edit),
                    heroTag: null,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  FloatingActionButton.extended(
                    backgroundColor: AppTheme.colors.primary,
                    onPressed: () async {
                      Modular.to.pushNamed('/chart', arguments: [
                        await store.getFittedPoints(triple.state.chartList),
                        triple.state.chartList,
                        store,
                      ]);
                    },
                    label: const Icon(Icons.show_chart),
                    heroTag: null,
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
