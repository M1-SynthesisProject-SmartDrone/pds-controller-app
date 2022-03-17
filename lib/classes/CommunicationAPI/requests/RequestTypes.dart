enum RequestTypes {
  ACK,
  START_DRONE,
  MANUAL_CONTROL,
  RECORD,
  DRONE_DATA,
  DRONE_INFOS
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
      default:
        return "";
    }
  }
}

