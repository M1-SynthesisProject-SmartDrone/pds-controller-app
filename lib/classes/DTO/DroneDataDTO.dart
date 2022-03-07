class DroneDataDTO {
  final int batteryRemaining;
  final String latitude;
  final String longitude;
  final int altitude;
  final int relativeAlt;
  final int vx;
  final int vy;
  final int vz;
  final int yawRotation;

  DroneDataDTO(
      {this.latitude = "00.0000000",
      this.longitude = "00.0000000",
      this.altitude = 0,
      this.batteryRemaining = 100,
      this.relativeAlt = 0,
      this.yawRotation = 0,
      this.vx = 0,
      this.vy = 0,
      this.vz = 0});
}
