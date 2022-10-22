import '../../domain/models/irrigation_record.dart';

abstract class IrrigationRecordLocalDataSource {
  Future<bool> exists(IrrigationRecord value);
  Future<List<IrrigationRecord>> getAll();
  Future<bool> insert(IrrigationRecord value);
  Future<bool> remove(String id);
}
