import 'package:flutter_triple/flutter_triple.dart';
import 'package:tcc/app/core/domain/domain.dart';
import 'package:tcc/app/modules/cras/submodules/irrigation_management/presentation/state/irrigation_management_state.dart';

class IrrigationManagementStore
    extends StreamStore<Failure, IrrigationManagementState> {
  IrrigationManagementStore()
      : super(IrrigationManagementState(
            readingTensiometer: List.generate(90, (index) => index + 1)));
}
