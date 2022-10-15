import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/domain/domain.dart';
import '../../../../../../core/presentation/themes/app_theme.dart';
import '../../../../../../core/presentation/widgets/custom_drawer.dart';
import '../../../../presentation/widgets/drop_down_widget.dart';
import '../../../../presentation/widgets/text_input_widget.dart';
import '../../../irrigation_management/presentation/widgets/line_text_custom_widget.dart';
import '../state/culture_data_state.dart';
import '../stores/culture_data_store.dart';
import '../stores/local_culture_data_store.dart';

class CultureDataPage extends StatefulWidget {
  final LocalCultureDataStore localCultureDataStore;
  final CultureDataStore store;
  const CultureDataPage(
      {Key? key, required this.localCultureDataStore, required this.store})
      : super(key: key);

  @override
  State<CultureDataPage> createState() => _CultureDataPageState();
}

class _CultureDataPageState extends State<CultureDataPage> {
  LocalCultureDataStore get localCultureDataStore =>
      widget.localCultureDataStore;
  CultureDataStore get store => widget.store;
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController dateinput;
  late final TextEditingController cultivateHybrid;
  //TODO: NOVOS CAMMPOS
  late final TextEditingController plantingSpace;
  late final TextEditingController linePlantingSpace;

  @override
  void initState() {
    super.initState();
    plantingSpace = TextEditingController();
    linePlantingSpace = TextEditingController();
    dateinput = TextEditingController();
    _formKey = GlobalKey<FormState>();
    cultivateHybrid = TextEditingController();

    localCultureDataStore.observer(onState: (state) {
      plantingSpace.text =
          state.cultureData.plantSpacing.toString().replaceAll('.', ',');
      store.onChangePlantSpacing(state.cultureData.plantSpacing);
      linePlantingSpace.text = state.cultureData.spacingBetweenRowsPlants
          .toString()
          .replaceAll('.', ',');
      store.onChangePlantRowSpacing(state.cultureData.spacingBetweenRowsPlants);
      store.onChangeCulture(state.cultureData.culture);
      cultivateHybrid.text = state.cultureData.cultivateHybrid;
      store.onChangeCultivateHybrid(state.cultureData.cultivateHybrid);
      store.onChangePlantinDate(DateTime.parse(state.cultureData.plantingDate));
      dateinput.text = DateFormat(" d 'de' MMMM 'de' y", "pt_BR")
          .format(DateTime.parse(state.cultureData.plantingDate));
      store.onChangeRootSystem(state.cultureData.rootSystem);
    });
    localCultureDataStore.fetchCultureData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Dados da Cultura'),
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Form(
              key: _formKey,
              child: TripleBuilder<CultureDataStore, Failure, CultureDataState>(
                  store: store,
                  builder: (context, triple) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const LineTextCustomWidget(
                          text: 'Dados da Cultura',
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropDownWidget<String>(
                            value: triple.state.culture,
                            onChanged: (value) {
                              store.onChangeCulture(value!);
                            },
                            items: const [
                              DropdownMenuItem(
                                child: Text('Soja'),
                                value: '0',
                              ),
                              DropdownMenuItem(
                                child: Text('Milho'),
                                value: '1',
                              ),
                              DropdownMenuItem(
                                child: Text('Feijão'),
                                value: '2',
                              ),
                              DropdownMenuItem(
                                child: Text('Café'),
                                value: '3',
                              ),
                            ],
                            labelText: 'Cultura',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextInputWidget(
                            controller: cultivateHybrid,
                            labelText: 'Clone/Cultivar/híbrido',
                            centerText: false,
                            onChanged: store.onChangeCultivateHybrid,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Campo Obrigatório";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: dateinput,
                            decoration: const InputDecoration(
                                suffixIcon: Icon(Icons.calendar_month),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1)),
                                labelText: "Data de Plantio"),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: triple.state.plantingDate,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101));
                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat(" d 'de' MMMM 'de' y", "pt_BR")
                                        .format(pickedDate);

                                store.onChangePlantinDate(pickedDate);
                                setState(() {
                                  dateinput.text = formattedDate;
                                });
                              } else {}
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Campo Obrigatório";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropDownWidget<int>(
                            value: triple.state.rootSystem,
                            onChanged: (value) =>
                                store.onChangeRootSystem(value!),
                            items: widget.store.state.effectiveRootSystemList
                                .map((value) {
                              return DropdownMenuItem(
                                child: Text("$value"),
                                value: value,
                              );
                            }).toList(),
                            labelText: 'Prof. efetiva do sistema radicular (Z)',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextInputWidget(
                            decimalInput: true,
                            controller: plantingSpace,
                            centerText: false,
                            labelText: 'Espaçamento entre plantas',
                            suffixText: 'm',
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                store.onChangePlantSpacing(
                                    double.parse(value.replaceAll(',', '.')));
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Campo Obrigatório";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextInputWidget(
                            decimalInput: true,
                            controller: linePlantingSpace,
                            centerText: false,
                            labelText: 'Espaçamento entre fileiras de plantas',
                            suffixText: 'm',
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                store.onChangePlantRowSpacing(
                                    double.parse(value.replaceAll(',', '.')));
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Campo Obrigatório";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppTheme.colors.primary,
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            await store.saveCultureData();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Dados da cultura salvos!'),
              ),
            );
          }
        },
        label: const Icon(Icons.save),
        heroTag: null,
      ),
    );
  }
}
