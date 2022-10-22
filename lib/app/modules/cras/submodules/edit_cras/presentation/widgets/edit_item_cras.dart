import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../domain/models/cras_chart.dart';
import '../../../../presentation/widgets/text_input_widget.dart';

class EditItemCras extends StatefulWidget {
  const EditItemCras({Key? key, required this.item, required this.onRemove})
      : super(key: key);

  final CrasChart item;
  final VoidCallback onRemove;

  @override
  State<EditItemCras> createState() => _EditItemCrasState();
}

class _EditItemCrasState extends State<EditItemCras> {
  late final TextEditingController kpa;
  late final TextEditingController humidity;
  late final TextEditingController humidityWeight;

  @override
  void initState() {
    super.initState();
    kpa = TextEditingController(text: widget.item.kpa.toString());
    humidity = TextEditingController(
        text: widget.item.humidity.toStringAsFixed(4).replaceAll('.', ','));
    humidityWeight = TextEditingController(
        text: (widget.item.humidity * 100).toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 30,
            child: TextInputWidget(
              //decimalInput: true,
              labelText: "kPa",
              controller: kpa,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value!.isEmpty) {
                  return "";
                } else if (int.parse(value) < 1) {
                  return "Deve ser maior que 1";
                }
                return null;
              },
              onChanged: (value) {
                if (value.isNotEmpty) {
                  widget.item.kpa = int.parse(value);
                }
              },
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 40,
            child: TextInputWidget(
              controller: humidity,
              decimalInput: true,
              labelText: 'Kg água/kg solo',
              onChanged: (value) {
                if (value.isNotEmpty) {
                  humidityWeight.text =
                      (double.parse(value.replaceAll(',', '.')) * 100)
                          .toStringAsFixed(2);
                  widget.item.humidity =
                      double.parse(value.replaceAll(',', '.'));
                } else {
                  humidityWeight.text = "";
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "Campo Obrigatório";
                } else if (double.parse(value.replaceAll(',', '.')) <= 0.0) {
                  return "Deve ser maior que 0";
                }
                return null;
              },
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 30,
            child: TextInputWidget(
              labelText: "%",
              controller: humidityWeight,
              readOnly: true,
            ),
          ),
          IconButton(
              onPressed: widget.onRemove, icon: const Icon(Icons.remove)),
        ],
      ),
    );
  }
}
