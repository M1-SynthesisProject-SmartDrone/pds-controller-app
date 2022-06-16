
enum ResponseTypes {
  START_DRONE,
  DRONE_DATA,
  DRONE_STATE,
  RESP_RECORD,
  ACK,
  RESP_PATH_GET,
  RESP_PATH_ONE,
  RESP_AUTOPILOT_INFOS,
  RESP_PATH_LAUNCH,
  RESP_REGAIN_CONTROL,
  RESP_RESUME_AUTOPILOT
}

extension ResponseTypesValues on ResponseTypes {
  String get value {
    switch(this) {
      case ResponseTypes.START_DRONE:
        return "RESP_START_DRONE";
      case ResponseTypes.ACK:
        return "RESP_ACK";
      case ResponseTypes.DRONE_DATA:
        return "RESP_DRONE_INFOS";
      case ResponseTypes.DRONE_STATE:
        return "RESP_DRONE_STATE";
      case ResponseTypes.RESP_RECORD:
        return "RESP_RECORD";
      case ResponseTypes.RESP_PATH_GET:
        return "RESP_PATH_GET";
      case ResponseTypes.RESP_PATH_ONE:
        return "RESP_PATH_ONE";
      case ResponseTypes.RESP_PATH_LAUNCH:
        return "RESP_PATH_LAUNCH";
      case ResponseTypes.RESP_AUTOPILOT_INFOS:
        return "RESP_AUTOPILOT_INFOS";
      case ResponseTypes.RESP_REGAIN_CONTROL:
        return "RESP_REGAIN_CONTROL";
      case ResponseTypes.RESP_RESUME_AUTOPILOT:
        return "RESP_RESUME_AUTOPILOT";
      default:
        return "";
    }
  }
}