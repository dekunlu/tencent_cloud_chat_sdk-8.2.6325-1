import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tencent_cloud_chat_sdk/enum/V2TimSDKListener.dart';
import 'package:tencent_cloud_chat_sdk/enum/history_msg_get_type_enum.dart';
import 'package:tencent_cloud_chat_sdk/enum/log_level_enum.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_callback.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_friend_info.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_message.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_value_callback.dart';
import 'package:tencent_cloud_chat_sdk/tencent_im_sdk_plugin.dart';

class GetFriendList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GetFriendListState();
  }
}

class _GetFriendListState extends State<GetFriendList> {
  String result = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    result = '';
  }

  pressedFunction() async {
    V2TimValueCallback<List<V2TimFriendInfo>> getFriendListRes =
        await TencentImSDKPlugin.v2TIMManager
            .getFriendshipManager()
            .getFriendList();
    setState(() {
      result = getFriendListRes.toJson().toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text('GetFriendList'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: Text('GetFriendList'),
              onPressed: () {
                pressedFunction();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(child: SingleChildScrollView(child: (Text(result))))
          ],
        ),
      ),
    ));
  }
}