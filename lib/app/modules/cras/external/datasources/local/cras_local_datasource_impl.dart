import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcc/app/modules/cras/domain/models/cras_chart.dart';
import 'package:tcc/app/modules/cras/domain/models/cras_equotion.dart';
import 'package:tcc/app/modules/cras/domain/models/culture_data.dart';
import 'package:tcc/app/modules/cras/domain/models/soil_data.dart';
import 'package:tcc/app/modules/cras/external/mappers/cras_equotion_mapper.dart';
import 'package:tcc/app/modules/cras/external/mappers/cras_mapper.dart';
import 'package:tcc/app/modules/cras/external/mappers/culture_data_mapper.dart';

import '../../../../../core/domain/helpers/errors/failure.dart';
import '../../../infra/datasources/cras_local_datasource.dart';
import '../../mappers/soil_data_mapper.dart';

class CrasLocalDataSourceImpl implements CrasLocalDataSource {
  final SharedPreferences _localStorage;

  const CrasLocalDataSourceImpl(this._localStorage);

  @override
  Future<bool> saveChart(List<String> value) async {
    try {
      final response = await _localStorage.setString('cras', jsonEncode(value));
      return response;
    } on Failure {
      rethrow;
    } catch (error, stackTrace) {
      throw DatasourceFailure(
          message: error.toString(), stackTrace: stackTrace);
    }
  }

  //REFATORAÇÃO PARA SALVAR A LISTA DO CRAS
  @override
  Future<bool> saveCras(List<CrasChart> value) async {
    try {
      final response = await _localStorage.setString(
          'cras_1',
          json.encode(value
              .map<Map<String, dynamic>>((e) => CrasMapper().to(e))
              .toList()));
      return response;
    } on Failure {
      rethrow;
    } catch (error, stackTrace) {
      throw DatasourceFailure(
          message: error.toString(), stackTrace: stackTrace);
    }
  }

  @override
  List<CrasChart> fetchCras() {
    try {
      final response = _localStorage.getString('cras_1');
      if (response == null) {
        return [];
      }
      return (json.decode(response) as List<dynamic>)
          .map<CrasChart>((e) => CrasMapper().from(e))
          .toList();
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
      var response = _localStorage.getString('cras');
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
  Future<bool> saveEquotion(CrasEquotion crasEquotion) async {
    try {
      final response = await _localStorage.setString(
          'curve_equation', jsonEncode(CrasEquotionMapper().to(crasEquotion)));
      return response;
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
      final response = _localStorage.getString('curve_equation');
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
  Future<bool> saveSoilData(SoilData soilData) async {
    try {
      final response = await _localStorage.setString(
          'soil_data', jsonEncode(SoilDataMapper().to(soilData)));
      return response;
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
      final response = _localStorage.getString('soil_data');
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
  Future<bool> saveCultureData(CultureData cultureData) async {
    Logger().v(CultureDataMapper().to(cultureData));

    try {
      final response = await _localStorage.setString(
          'culture_data', jsonEncode(CultureDataMapper().to(cultureData)));
      return response;
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
      final response = _localStorage.getString('culture_data');
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
