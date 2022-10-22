import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:tcc/app/modules/cras/domain/models/irrigation_record.dart';
import '../../../../../../core/domain/domain.dart';
import '../../../../../../core/presentation/themes/app_theme.dart';
import '../../../../../../core/presentation/widgets/custom_drawer.dart';
import '../state/irrigation_records_state.dart';
import '../store/irrigation_records_store.dart';
import '../store/tab_store.dart';
import '../widgets/register_card_item_widget.dart';

class IrrigationRecordsPage extends StatefulWidget {
  final IrrigationRecordsStore store;
  final TabStore tabStore;
  const IrrigationRecordsPage({
    Key? key,
    required this.store,
    required this.tabStore,
  }) : super(key: key);

  @override
  State<IrrigationRecordsPage> createState() => _IrrigationRecordsPageState();
}

class _IrrigationRecordsPageState extends State<IrrigationRecordsPage> {
  IrrigationRecordsStore get store => widget.store;

  final ValueNotifier<double> summation = ValueNotifier<double>(0.0);

  @override
  void initState() {
    super.initState();
    store.fetchIrrigations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f7),
      drawer: const CustomDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Registros das Irrigações'),
        backgroundColor: AppTheme.colors.primary,
      ),
      body: ValueListenableBuilder<int>(
          valueListenable: widget.tabStore.selectedTab,
          builder: (context, value, _) {
            if (value == 0) {
              return ValueListenableBuilder<List<IrrigationRecord>>(
                valueListenable: widget.store.irrigations,
                builder: (context, value, _) {
                  if (widget.store.fetchPivot().isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          'Nenhum Registro Encontrado',
                          style: TextStyle(
                            fontSize: 20,
                            color: AppTheme.colors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 800),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Card(
                                color: AppTheme.colors.primary,
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Somatório das Lâminas',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      ValueListenableBuilder<double>(
                                          valueListenable: summation,
                                          builder: (context, value, _) {
                                            return Text(
                                              "${widget.store.fetchSummation(0).toStringAsFixed(2)} mm",
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: widget.store.fetchPivot().length,
                              itemBuilder: (context, index) {
                                var register = widget.store.fetchPivot()[index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 8, bottom: 8),
                                  child: SizedBox(
                                    child: RegisterCardItemWidget(
                                      register: register,
                                      onTapDelete: () async {
                                        await store.removeRegisters(register);
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return ValueListenableBuilder<List<IrrigationRecord>>(
                valueListenable: widget.store.irrigations,
                builder: (context, value, _) {
                  if (widget.store.fetchDrip().isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          'Nenhum Registro Encontrado',
                          style: TextStyle(
                            fontSize: 20,
                            color: AppTheme.colors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 800),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Card(
                                color: AppTheme.colors.primary,
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Somatório das Lâminas',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      ValueListenableBuilder<double>(
                                          valueListenable: summation,
                                          builder: (context, value, _) {
                                            return Text(
                                              "${widget.store.fetchSummation(1).toStringAsFixed(2)} mm",
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: widget.store.fetchDrip().length,
                              itemBuilder: (context, index) {
                                var register = widget.store.fetchDrip()[index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 8, bottom: 8),
                                  child: SizedBox(
                                    child: RegisterCardItemWidget(
                                      register: register,
                                      onTapDelete: () async {
                                        await store.removeRegisters(register);
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }),
      floatingActionButton: ValueListenableBuilder<List<IrrigationRecord>>(
        valueListenable: widget.store.irrigations,
        builder: (context, value, _) {
          if (value.isNotEmpty) {
            return FloatingActionButton.extended(
                backgroundColor: AppTheme.colors.primary,
                onPressed: () {
                  Modular.to.pushNamed(
                    './irrigation-record-chart',
                  );
                },
                label: const Icon(Icons.show_chart));
          }
          return Container();
        },
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: widget.tabStore.selectedTab,
        builder: (context, value, _) {
          return BottomNavigationBar(
            onTap: (value) {
              widget.tabStore.onChangeTab(value);
            },
            currentIndex: value,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: Image.asset(
                      'assets/images/watering-plants.png',
                      height: 40,
                    )),
                label: "Pivô Central",
              ),
              BottomNavigationBarItem(
                icon: Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: Image.asset(
                      'assets/images/watering-plants.png',
                      height: 40,
                    )),
                label: "Gotejamento",
              ),
            ],
            selectedLabelStyle:
                const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          );
        },
      ),
    );
  }
}
