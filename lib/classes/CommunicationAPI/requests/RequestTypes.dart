enum RequestTypes {
  ACK,
  START_DRONE,
  MANUAL_CONTROL
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
      default:
        return "";
    }
  }
}

