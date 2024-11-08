import 'package:tencent_cloud_chat_sdk/web/utils/utils.dart';

class KickGroupMember {
  static Object formatParams(Map<String, dynamic> params) => mapToJSObj({
        'groupID': params['groupID'],
        'userIDList': params['memberList'],
        'reason': params['reason'],
      });

  static formatResult(params) {
    final userList = params.successUserIDList as List;
    return userList.map((e) => {'memberID': e, 'result': 1}).toList();
  }
}
