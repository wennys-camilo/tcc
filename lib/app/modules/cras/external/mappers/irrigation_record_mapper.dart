import '../../domain/models/irrigation_record.dart';

class IrrigationRecordMapper {
  Map<String, dynamic> toMap(IrrigationRecord irrigationRecord) {
    return {
      'id': irrigationRecord.id,
      'cultura': irrigationRecord.cultura,
      'culTivarHibrido': irrigationRecord.culTivarHibrido,
      'dataPlantio': irrigationRecord.dataPlantio,
      'dataLeitura': irrigationRecord.dataLeitura,
      'tensaoMedia': irrigationRecord.tensaoMedia,
      'laminaBruta': irrigationRecord.laminaBruta,
    };
  }

  IrrigationRecord fromMap(Map<String, dynamic> map) {
    return IrrigationRecord(
      id: map['id'],
      cultura: map['cultura'] ?? '',
      culTivarHibrido: map['culTivarHibrido'] ?? '',
      dataPlantio: map['dataPlantio'] ?? '',
      dataLeitura: map['dataLeitura'] ?? '',
      tensaoMedia: map['tensaoMedia'] ?? '',
      laminaBruta: map['laminaBruta'] ?? '',
    );
  }
}
