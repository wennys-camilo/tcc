import 'package:tcc/app/modules/cras/domain/models/cras_equotion.dart';

class CrasEquotionMapper {
  Map<String, dynamic> to(CrasEquotion crasEquotion) {
    return {
      'coefficient': crasEquotion.coefficient,
      'exponent': crasEquotion.exponent,
    };
  }

  CrasEquotion from(Map<String, dynamic> map) {
    return CrasEquotion(
      coefficient: map['coefficient'],
      exponent: map['exponent'],
    );
  }
}
