abstract class CrasLocalDataSource {
  Future<void> save(List<String> value);
  Future<List<String>> fetch();
}
