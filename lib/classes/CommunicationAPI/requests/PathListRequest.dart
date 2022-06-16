import 'Request.dart';
import 'RequestTypes.dart';

class PathListRequest extends Request{

  PathListRequest() : super(RequestTypes.PATH_LIST);
  @override
  Map<String, dynamic> contentToJson() {
    return {};
  }

}