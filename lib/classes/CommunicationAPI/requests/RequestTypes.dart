enum RequestTypes {
  ACK,
  START_DRONE,
  MANUAL_CONTROL,
  RECORD,
  DRONE_DATA,
  DRONE_INFOS,
  PATH_LIST,
  PATH_ONE,
  PATH_LAUNCH,
  AUTOPILOT_INFOS,
  REGAIN_CONTROL,
  RESUME_AUTOPILOT
}

// Cannot infer values directly, that's a bit sad
extension RequestTypeValue on RequestTypes {
  String get value {
    switch (this) {
      case RequestTypes.ACK:
        return "ACK";
      case RequestTypes.START_DRONE:
        return "START_DRONE";
      case RequestTypes.MANUAL_CONTROL:
        return "MANUAL_CONTROL";
      case RequestTypes.RECORD:
        return "RECORD";
      case RequestTypes.DRONE_DATA:
        return "DRONE_DATA";
      case RequestTypes.DRONE_INFOS:
        return "DRONE_INFOS";
      case RequestTypes.PATH_LIST:
        return "PATH_LIST";
      case RequestTypes.PATH_ONE:
        return "PATH_ONE";
      case RequestTypes.PATH_LAUNCH:
        return "PATH_LAUNCH";
      case RequestTypes.AUTOPILOT_INFOS:
        return "AUTOPILOT_INFOS";
        case RequestTypes.REGAIN_CONTROL:
      return "REGAIN_CONTROL";
      case RequestTypes.RESUME_AUTOPILOT:
        return "RESUME_AUTOPILOT";
      default:
        return "";
    }
  }
}

