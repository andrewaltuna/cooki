part of 'beacon_view_model.dart';

sealed class BeaconEvent extends Equatable {
  const BeaconEvent();

  @override
  List<Object> get props => [];
}

class BeaconSubscriptionInitialized extends BeaconEvent {
  const BeaconSubscriptionInitialized();
}
