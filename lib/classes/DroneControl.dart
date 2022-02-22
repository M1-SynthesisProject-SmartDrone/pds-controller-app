class DroneControl{
  // --- Variables ---
  double x = 0;
  double y = 0;
  double z = 0;
  double r = 0;

  bool isArmed = false;
  bool isRecording = false;

  double altitude = 0;
  double speed = 0;
  double position = 0;


  static final DroneControl _droneControl = DroneControl._internal();
  // --- Methods ---

  factory DroneControl(){
    return _droneControl;
  }

  DroneControl._internal();

  void updateData(double position, double altitude, double speed){
    this.position = position;
    this.altitude = altitude;
    this.speed = speed;
  }

  void arm(){
    isArmed = true;
  }

  void unArm(){
    isArmed = false;
  }

  void startRecord(){
    isRecording = true;
  }

  void endRecord(){
    isRecording = false;
  }


}