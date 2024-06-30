import 'package:equatable/equatable.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_helper/common/enum/view_model_status.dart';
import 'package:grocery_helper/common/helper/permission_helper.dart';
import 'package:grocery_helper/feature/beacon/data/repository/beacon_repository_interface.dart';

part 'beacon_event.dart';
part 'beacon_state.dart';

class BeaconViewModel extends Bloc<BeaconEvent, BeaconState> {
  BeaconViewModel(this._beaconRepository) : super(const BeaconState()) {
    on<BeaconSubscriptionInitialized>(_onSubscriptionInitialized);
    on<BeaconPermissionsValidated>(_onPermissionsValidated);
  }

  final BeaconRepositoryInterface _beaconRepository;

  Future<void> _onSubscriptionInitialized(
    BeaconSubscriptionInitialized _,
    Emitter<BeaconState> emit,
  ) async {
    _beaconRepository.initializeRegion();

    await emit.forEach(
      _beaconRepository.rangingStream,
      onData: (rangingResult) {
        return state.copyWith(
          beacons: rangingResult.beacons,
        );
      },
    );
  }

  Future<void> _onPermissionsValidated(
    BeaconPermissionsValidated event,
    Emitter<BeaconState> emit,
  ) async {
    emit(state.copyWith(permissionStatus: ViewModelStatus.loading));

    final arePermissionsGranted =
        await PermissionHelper.validateBeaconPermissions();

    emit(
      state.copyWith(
        permissionStatus: ViewModelStatus.success,
        arePermissionsGranted: arePermissionsGranted,
      ),
    );
  }
}
