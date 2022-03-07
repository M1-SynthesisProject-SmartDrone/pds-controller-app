
/// Handles the manual control command to be sent to the server
class ManualControlDTO {
  double x;
  double y;
  double z;
  double r;

  ManualControlDTO({this.x = 0.0, this.y = 0.0, this.z = 0.0, this.r = 0.0});
}