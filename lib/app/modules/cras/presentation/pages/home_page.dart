import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:tcc/app/core/presentation/widgets/custom_drawer.dart';
import 'package:tcc/app/core/presentation/widgets/show_dialog_widget.dart';
import 'package:tcc/app/modules/cras/presentation/widgets/item_cras.dart';
import 'package:tcc/app/modules/cras/presentation/widgets/steps_dialog_widget.dart';
import '../../../../core/domain/helpers/errors/failure.dart';
import '../../../../core/presentation/themes/app_theme.dart';
import '../state/cras_state.dart';
import '../stores/cras_store.dart';

class HomePage extends StatefulWidget {
  final CrasStore store;
  const HomePage({Key? key, required this.store}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CrasStore get store => widget.store;

  @override
  void initState() {
    super.initState();
    store.fetchList();
  }

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
                child: TripleBuilder<CrasStore, Failure, CrasState>(
                    store: store,
                    builder: (context, triple) {
                      if (triple.isLoading) {
                        return const CircularProgressIndicator(
                          color: Colors.blue,
                        );
                      }

                      if (triple.state.chartList.isNotEmpty) {
                        return Center(
                          child: SingleChildScrollView(
                            child: Column(children: [
                              Icon(
                                Icons.query_stats_outlined,
                                size: 80,
                                color: AppTheme.colors.primary,
                              ),
                              ...List.generate(triple.state.chartList.length,
                                  (index) {
                                return Column(
                                  children: [
                                    ItemCras(
                                      key: ObjectKey(
                                          triple.state.chartList[index]),
                                      item: triple.state.chartList[index],
                                      index: index,
                                    ),
                                  ],
                                );
                              }).toList(),
                            ]),
                          ),
                        );
                      } else {
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  flex: 5,
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15.0)),
                                          border: Border.all(
                                              color: AppTheme.colors.primary)),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Etapas \nde preenchimento',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: AppTheme.colors.primary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              const StepsDialogWidget()
                                                  .show(context);
                                            },
                                            child: Icon(
                                              Icons.help,
                                              size: 100,
                                              color: AppTheme.colors.primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                  flex: 5,
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15.0)),
                                          border: Border.all(
                                              color: AppTheme.colors.primary)),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Curva de Retenção \nde Água do Solo',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: AppTheme.colors.primary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () => Modular.to
                                                .navigate('/edit-cras/'),
                                            child: Icon(
                                              Icons.edit_note,
                                              size: 100,
                                              color: AppTheme.colors.primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    })),
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
                      if (triple.state.chartList.length > 1) {
                        Modular.to.pushNamed('/chart', arguments: [
                          await store.getFittedPoints(triple.state.chartList),
                          triple.state.chartList,
                          store,
                        ]);
                      } else {
                        const ShowDialogWidget(
                          bodyText: "Insira ao menos dois pontos!",
                        ).show(context);
                      }
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
