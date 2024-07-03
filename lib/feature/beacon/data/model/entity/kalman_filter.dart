import 'package:grocery_helper/common/constants/beacon_constants.dart';

class KalmanFilter {
  KalmanFilter({
    required this.processNoise,
    required this.measurementNoise,
    required this.estimatedError,
    required this.lastEstimate,
  });

  factory KalmanFilter.fromLastEstimateWithDefaultValues(
    int lastEstimate,
  ) {
    return KalmanFilter(
      processNoise: BeaconConstants.processNoise,
      measurementNoise: BeaconConstants.measurementNoise,
      estimatedError: BeaconConstants.estimatedError,
      lastEstimate: lastEstimate,
    );
  }

  double processNoise;
  double measurementNoise;
  double estimatedError;
  int lastEstimate;

  int filter(int rssi) {
    // Prediction update
    estimatedError += processNoise;

    // Kalman gain
    double kalmanGain = estimatedError / (estimatedError + measurementNoise);

    // Measurement update
    lastEstimate = (lastEstimate + kalmanGain * (rssi - lastEstimate)).toInt();
    estimatedError = (1 - kalmanGain) * estimatedError;

    return lastEstimate;
  }
}
