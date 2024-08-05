class BeaconConstants {
  const BeaconConstants._();

  static const proximityUUID = '0D89035E-7457-42EB-8250-CE81C78EB402';

  // Kalman filtering
  static const processNoise = 0.15;
  static const measurementNoise = 1.5;
  static const estimatedError = 1.0;

  // Distance calculation
  static const rssiAtOneMeter = -59;
  static const pathLossExponent = 3.0;
}
