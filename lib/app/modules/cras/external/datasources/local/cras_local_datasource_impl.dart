import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tcc/app/modules/cras/domain/models/cras_equotion.dart';
import 'package:tcc/app/modules/cras/domain/models/culture_data.dart';
import 'package:tcc/app/modules/cras/domain/models/soil_data.dart';
import 'package:tcc/app/modules/cras/external/mappers/cras_equotion_mapper.dart';
import 'package:tcc/app/modules/cras/external/mappers/culture_data_mapper.dart';

import '../../../../../core/domain/helpers/errors/failure.dart';
import '../../../infra/datasources/cras_local_datasource.dart';
import '../../mappers/soil_data_mapper.dart';

class CrasLocalDataSourceImpl implements CrasLocalDataSource {
  final FlutterSecureStorage _localStorage;

  const CrasLocalDataSourceImpl(this._localStorage);

  @override
  Future<void> saveChart(List<String> value) async {
    try {
      await _localStorage.write(key: 'cras', value: jsonEncode(value));
    } on Failure {
      rethrow;
    } catch (error, stackTrace) {
      throw DatasourceFailure(
          message: error.toString(), stackTrace: stackTrace);
    }
  }

  @override
  Future<List<String>> fetchChart() async {
    try {
      List<dynamic>? list;
      var response = await _localStorage.read(key: 'cras');
      if (response != null) {
        list = jsonDecode(response);
      } else if (response == null) {
        return [];
      }
      return (list as List).cast<String>();
    } on Failure {
      rethrow;
    } catch (error, stackTrace) {
      throw DatasourceFailure(
          message: error.toString(), stackTrace: stackTrace);
    }
  }

  @override
  Future<void> saveEquotion(CrasEquotion crasEquotion) async {
    try {
      await _localStorage.write(
          key: 'curve_equation',
          value: jsonEncode(CrasEquotionMapper().to(crasEquotion)));
    } on Failure {
      rethrow;
    } catch (error, stackTrace) {
      throw DatasourceFailure(
          message: error.toString(), stackTrace: stackTrace);
    }
  }

  @override
  Future<CrasEquotion?> fetchEquotion() async {
    try {
      final response = await _localStorage.read(key: 'curve_equation');
      if (response != null) {
        return CrasEquotionMapper().from(jsonDecode(response));
      }
      return null;
    } on Failure {
      rethrow;
    } catch (error, stackTrace) {
      throw DatasourceFailure(
          message: error.toString(), stackTrace: stackTrace);
    }
  }

  @override
  Future<void> saveSoilData(SoilData soilData) async {
    try {
      await _localStorage.write(
          key: 'soil_data', value: jsonEncode(SoilDataMapper().to(soilData)));
    } on Failure {
      rethrow;
    } catch (error, stackTrace) {
      throw DatasourceFailure(
          message: error.toString(), stackTrace: stackTrace);
    }
  }

  @override
  Future<SoilData?> fetchSoilData() async {
    try {
      final response = await _localStorage.read(key: 'soil_data');
      if (response != null) {
        return SoilDataMapper().from(jsonDecode(response));
      }
      return null;
    } on Failure {
      rethrow;
    } catch (error, stackTrace) {
      throw DatasourceFailure(
          message: error.toString(), stackTrace: stackTrace);
    }
  }

  @override
  Future<void> saveCultureData(CultureData cultureData) async {
    try {
      await _localStorage.write(
          key: 'culture_data',
          value: jsonEncode(CultureDataMapper().to(cultureData)));
    } on Failure {
      rethrow;
    } catch (error, stackTrace) {
      throw DatasourceFailure(
          message: error.toString(), stackTrace: stackTrace);
    }
  }

  @override
  Future<CultureData?> fetchCultureData() async {
    try {
      final response = await _localStorage.read(key: 'culture_data');
      if (response != null) {
        return CultureDataMapper().from(jsonDecode(response));
      }
      return null;
    } on Failure {
      rethrow;
    } catch (error, stackTrace) {
      throw DatasourceFailure(
          message: error.toString(), stackTrace: stackTrace);
    }
  }
}
