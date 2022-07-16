import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcc/app/modules/cras/domain/models/cras_chart.dart';
import 'package:tcc/app/modules/cras/submodules/edit_cras/presentation/store/edit_cras_store.dart';
import 'package:tcc/app/modules/cras/submodules/edit_cras/presentation/widgets/edit_item_cras.dart';
import '../../../../../../core/presentation/themes/app_theme.dart';

class EditCrasPage extends StatefulWidget {
  final EditCrasStore store;

  const EditCrasPage({Key? key, required this.store}) : super(key: key);

  @override
  State<EditCrasPage> createState() => _EditCrasPageState();
}

class _EditCrasPageState extends State<EditCrasPage> {
  EditCrasStore get store => widget.store;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    store.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Curva de Retenção de Água do Solo'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Form(
                key: formKey,
                child: FutureBuilder<List<CrasChart>>(
                  future: store.fetch(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return FormField<List<CrasChart>>(
                        initialValue: snapshot.data,
                        validator: (sizes) {
                          if (sizes!.isEmpty) return 'Insira um tamanho';
                          return null;
                        },
                        builder: (state) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                        onPressed: () {
                                          state.value!.add(
                                              CrasChart(kpa: 0, humidity: 0));
                                          state.didChange(state.value);
                                        },
                                        icon: const Icon(Icons.add),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: state.value!.map((size) {
                                    return EditItemCras(
                                      key: ObjectKey(size),
                                      item: size,
                                      onRemove: () {
                                        state.value?.remove(size);
                                        state.didChange(state.value);
                                      },
                                    );
                                  }).toList(),
                                ),
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
                                Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 800),
                                  padding: const EdgeInsets.all(15.0),
                                  child: SizedBox(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width,
                                    child: TextButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor:
                                                AppTheme.colors.primary),
                                        child: const Text(
                                          'Salvar',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        onPressed: () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            formKey.currentState!.save();
                                            await store.save();
                                            Modular.to.navigate('/cras');
                                          }
                                        }),
                                  ),
                                ),
                                Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 800),
                                  padding: const EdgeInsets.only(
                                      left: 15, top: 0, right: 15, bottom: 15),
                                  child: SizedBox(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width,
                                    child: TextButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor:
                                                AppTheme.colors.red),
                                        child: const Text(
                                          'Cancelar',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        onPressed: () =>
                                            Modular.to.navigate('/cras')),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        onSaved: (value) => store.onChangeList(value!),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              )),
        ),
      ),
    );
  }
}
