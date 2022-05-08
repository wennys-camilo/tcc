import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../../core/domain/helpers/errors/failure.dart';
import '../../../infra/datasources/cras_local_datasource.dart';

class CrasLocalDataSourceImpl implements CrasLocalDataSource {
  final FlutterSecureStorage _localStorage;

  const CrasLocalDataSourceImpl(this._localStorage);

  @override
  Future<void> save(List<String> value) async {
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
  Future<List<String>> fetch() async {
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
}
