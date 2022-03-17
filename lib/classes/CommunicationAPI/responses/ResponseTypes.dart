
enum ResponseTypes {
  START_DRONE,
  DRONE_DATA,
  DRONE_STATE,
  RECORD,
  ACK
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
      case ResponseTypes.RECORD:
        return "RESP_RECORD";
      default:
        return "";
    }
  }
}