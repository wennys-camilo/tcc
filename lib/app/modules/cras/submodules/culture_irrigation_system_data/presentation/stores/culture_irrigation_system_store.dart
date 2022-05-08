import 'package:flutter_triple/flutter_triple.dart';
import 'package:tcc/app/core/domain/domain.dart';
import 'package:tcc/app/modules/cras/submodules/culture_irrigation_system_data/presentation/state/culture_irrigation_system_state.dart';

class CultureIrrigationSystemStore
    extends StreamStore<Failure, CultureIrrigationSystemState> {
  CultureIrrigationSystemStore()
      : super(
          CultureIrrigationSystemState(
            irrigationEfficiency: List.generate(30, (i) => i + 70),
            effectiveRootSystemList: List.generate(139, (i) => i + 7),
          ),
        );
}
