class IrrigationRecord {
  final String id;
  final String cultura;
  final String culTivarHibrido;
  final String dataPlantio;
  final String dataLeitura;
  final String tensaoMedia;
  final String laminaBruta;
  final int typeSystem;

  const IrrigationRecord({
    required this.id,
    required this.cultura,
    required this.culTivarHibrido,
    required this.dataPlantio,
    required this.dataLeitura,
    required this.tensaoMedia,
    required this.laminaBruta,
    required this.typeSystem,
  });
}
