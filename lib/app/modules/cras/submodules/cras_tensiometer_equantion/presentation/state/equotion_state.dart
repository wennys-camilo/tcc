import 'package:tcc/app/modules/cras/domain/models/cras_equotion.dart';

class EquotionState {
  final CrasEquotion crasEquotion;
  EquotionState({
    required this.crasEquotion,
  });

  EquotionState copyWith({
    CrasEquotion? crasEquotion,
  }) {
    return EquotionState(
      crasEquotion: crasEquotion ?? this.crasEquotion,
    );
  }

  static EquotionState initialState() {
    return EquotionState(
      crasEquotion: const CrasEquotion(coefficient: '', exponent: ''),
    );
  }
}
