import 'package:tcc/app/modules/cras/domain/models/cras_chart.dart';

class EditCrasState {
  final List<CrasChart> listCras;
  EditCrasState({
    required this.listCras,
  });

  static EditCrasState initialState() {
    return EditCrasState(listCras: []);
  }

  EditCrasState copyWith({
    List<CrasChart>? listCras,
  }) {
    return EditCrasState(
      listCras: listCras ?? this.listCras,
    );
  }
}
