import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/domain/helpers/errors/failure.dart';
import '../../../domain/models/irrigation_record.dart';
import '../../../infra/datasources/irrigation_record_local_datasource.dart';
import '../../mappers/irrigation_record_mapper.dart';

class IrrigationRecordLocalDataSourceImpl
    implements IrrigationRecordLocalDataSource {
  final SharedPreferences _localStorage;

  const IrrigationRecordLocalDataSourceImpl(this._localStorage);

  @override
  Future<bool> exists(IrrigationRecord value) async {
    try {
      final records = await getAll();
      if (records.contains(value)) {
        return true;
      }
      return false;
    } on Failure {
      rethrow;
    } catch (error, stackTrace) {
      throw DatasourceFailure(
          message: error.toString(), stackTrace: stackTrace);
    }
  }

  @override
  Future<List<IrrigationRecord>> getAll() async {
    try {
      final encodedResponse = _localStorage.getString('irrigation_record');
      if (encodedResponse != null) {
        final response = (json.decode(encodedResponse) as List<dynamic>)
            .map<IrrigationRecord>(
                (item) => IrrigationRecordMapper().fromMap(item))
            .toList();
        return response;
      }
      return [];
    } on Failure {
      rethrow;
    } catch (error, stackTrace) {
      throw DatasourceFailure(
          message: error.toString(), stackTrace: stackTrace);
    }
  }

  @override
  Future<bool> insert(IrrigationRecord value) async {
    try {
      final irrigationsRegister = await getAll();
      List<IrrigationRecord> aux = [...irrigationsRegister, value];
      //if (favorites.contains(value)) return;
      final response = await _localStorage.setString(
          'irrigation_record',
          jsonEncode(
              aux.map((e) => IrrigationRecordMapper().toMap(e)).toList()));
      return response;
    } on Failure {
      rethrow;
    } catch (error, stackTrace) {
      throw DatasourceFailure(
          message: error.toString(), stackTrace: stackTrace);
    }
  }

  @override
  Future<bool> remove(String id) async {
    try {
      final registers = await getAll();
      List<IrrigationRecord> auxRegisters = [];
      for (var element in registers) {
        if (element.id == id) {
          auxRegisters.addAll([...registers]..remove(element));
          final response = await _localStorage.setString(
              'irrigation_record',
              jsonEncode(auxRegisters
                  .map((e) => IrrigationRecordMapper().toMap(e))
                  .toList()));
          return response;
        }
      }
      return false;
    } on Failure {
      rethrow;
    } catch (error, stackTrace) {
      throw DatasourceFailure(
          message: error.toString(), stackTrace: stackTrace);
    }
  }
}
