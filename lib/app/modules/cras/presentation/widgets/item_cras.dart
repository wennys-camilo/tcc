import 'package:flutter/material.dart';

import 'package:tcc/app/modules/cras/domain/models/cras_chart.dart';
import 'package:tcc/app/modules/cras/presentation/widgets/text_input_widget.dart';

class ItemCras extends StatefulWidget {
  const ItemCras({
    Key? key,
    required this.index,
    required this.item,
  }) : super(key: key);
  final int index;
  final CrasChart item;

  @override
  State<ItemCras> createState() => _ItemCrasState();
}

class _ItemCrasState extends State<ItemCras> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            flex: 30,
            child: Column(
              children: [
                widget.index == 0
                    ? Column(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(bottom: 12),
                            child: Text(
                              'Poetencial',
                              maxLines: 1,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    : Container(),
                TextInputWidget(
                  initalValue: widget.item.kpa.toString(),
                  enabled: false,
                  labelText: "Kpa",
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 40,
            child: Column(
              children: [
                widget.index == 0
                    ? const Padding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: Text(
                          'Umidade',
                          maxLines: 1,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    : Container(),
                TextInputWidget(
                  initalValue: widget.item.humidity.toStringAsFixed(4),
                  labelText: 'Kg água/kg solo',
                  enabled: false,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 30,
            child: Column(
              children: [
                widget.index == 0
                    ? const Padding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: Text(
                          'Umidade em Peso',
                          maxLines: 1,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    : Container(),
                TextInputWidget(
                  labelText: "%",
                  initalValue: (widget.item.humidity * 100).toStringAsFixed(2),
                  enabled: false,
                  readOnly: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
