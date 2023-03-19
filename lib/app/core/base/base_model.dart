import '../utils/utils.dart';

enum ResponseState { SUCCESS, FAILURE, NO_INTERNET }

class BaseModel<T> {
  String? uiMessage;
  String? message;
  int? responseCode;
  int? status;
  T? t;
  ResponseState? responseState;
  BaseModel.fromJSON(Map<String,dynamic> json){
    List? bListMap = getMapCheckedValue(json, 'results', []);
    uiMessage = getMapCheckedString(json, 'ui_message',defaultValue: getString('something_went_wrong'));
    message = getMapCheckedString(json, 'message');
    responseCode = getMapCheckedInt(json, 'response_code');
    status = getMapCheckedInt(json, 'status');
    if (bListMap!.isNotEmpty) {
      responseState = ResponseState.SUCCESS;
    } else {
      responseState = ResponseState.FAILURE;
    }
  }
}
