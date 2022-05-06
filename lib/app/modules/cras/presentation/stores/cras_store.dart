import 'package:flutter_triple/flutter_triple.dart';
import '../state/cras_state.dart';

class CrasStore extends StreamStore<Exception, CrasState> {
  CrasStore() : super(CrasState());
}
