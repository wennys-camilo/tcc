import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/presentation/themes/app_theme.dart';
import '../../../../domain/models/irrigation_record.dart';
import '../../../soil_data/presentation/utils/culture_type.dart';

class RegisterCardItemWidget extends StatelessWidget {
  final IrrigationRecord register;
  final void Function()? onTapDelete;
  const RegisterCardItemWidget(
      {Key? key, required this.register, required this.onTapDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      CultureType().name(
                        register.cultura,
                      ),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    InkWell(
                      onTap: onTapDelete,
                      child: const Icon(
                        Icons.delete,
                        size: 18,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.colors.primary,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(2.0)), //
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      DateFormat('dd/MM/yyy').format(
                        DateTime.parse(register.dataLeitura),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Tensão Média',
                    ),
                    Text("${register.tensaoMedia} (kPa)")
                  ],
                ),
                const Divider(
                  thickness: 0.8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Lâmina Bruta',
                    ),
                    Text("${register.laminaBruta} (mm)")
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
