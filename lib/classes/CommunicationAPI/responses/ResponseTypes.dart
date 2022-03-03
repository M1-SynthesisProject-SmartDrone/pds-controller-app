
enum ResponseTypes {
  ANSWER,
  DRONE_DATA,
  DRONE_STATE,
  RECORD
}

extension ResponseTypesValues on ResponseTypes {
  String get value {
    switch(this) {
      case ResponseTypes.ANSWER:
        return "ANSWER";
      case ResponseTypes.DRONE_DATA:
        return "DRONE_DATA";
      case ResponseTypes.DRONE_STATE:
        return "DRONE_STATE";
      case ResponseTypes.RECORD:
        return "RECORD";
      default:
        return "";
    }
  }
}