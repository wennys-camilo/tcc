import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:tcc/app/core/domain/domain.dart';
import 'package:tcc/app/core/presentation/themes/app_theme.dart';
import 'package:tcc/app/core/presentation/widgets/custom_drawer.dart';
import 'package:tcc/app/modules/cras/submodules/irrigation_records/presentation/store/irrigation_records_store.dart';

import '../state/irrigation_records_state.dart';
import '../widgets/register_card_item_widget.dart';

class IrrigationRecordsPage extends StatefulWidget {
  final IrrigationRecordsStore store;

  const IrrigationRecordsPage({Key? key, required this.store})
      : super(key: key);

  @override
  State<IrrigationRecordsPage> createState() => _IrrigationRecordsPageState();
}

class _IrrigationRecordsPageState extends State<IrrigationRecordsPage> {
  IrrigationRecordsStore get store => widget.store;

  @override
  void initState() {
    super.initState();
    store.fetchRegisters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f7),
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Registros das Irrigações'),
        backgroundColor: AppTheme.colors.primary,
      ),
      body:
          TripleBuilder<IrrigationRecordsStore, Failure, IrrigationRecordState>(
              store: store,
              builder: (context, triple) {
                if (triple.state.irrigationRegisters.isEmpty) {
                  return const Center(
                    child: Text('Nenhum registro de irrigação'),
                  );
                }

                if (triple.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Somatório das Lâminas',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${triple.state.summation.toStringAsFixed(2)} mm",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: triple.state.irrigationRegisters.length,
                        itemBuilder: (context, index) {
                          var register =
                              triple.state.irrigationRegisters[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 8, bottom: 8),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.25,
                              child: RegisterCardItemWidget(
                                register: register,
                                onTapDelete: () async {
                                  await store.removeRegisters(register);
                                  await store.fetchRegisters();
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }),
    );
  }
}
