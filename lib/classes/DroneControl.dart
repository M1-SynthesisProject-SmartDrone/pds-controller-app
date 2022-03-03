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

  void switchArm(){
    if(isArmed == false){
      isArmed = true;
    }
    else{
      isArmed = false;
    }
  }

  void arm(){
    isArmed = true;
  }

  void unArm(){
    isArmed = false;
  }

  void switchRecording(){
    if(isRecording == false){
      isRecording = true;
    }
    else{
      isRecording = false;
    }
  }

  void startRecord(){
    isRecording = true;
  }

  void endRecord(){
    isRecording = false;
  }

  // --- Drone Flying Control ---

  // rotation
  void resetRotation(){
    r = 0;
  }

  void rotateLeft(){
    r = 1;
  }

  void rotateRight(){
    r = -1;
  }

  // altitude control
  void resetVertical(){
    z = 0;
  }

  void moveUp(){
    z = 0.5;
  }

  void moveDown(){
    z = -0.5;
  }

  // direction

  void setDirection(double x, double y){
    this.x = x;
    this.y = y;
  }

  void resetDirection(){
    x = 0;
    y = 0;
  }


  @override
  String toString() {
    return "x: " + x.toString() +" y: " + y.toString() + " z: " + z.toString() + " r: " + r.toString() + " arm: " + isArmed.toString() + " isRec: " + isRecording.toString();
  }
}