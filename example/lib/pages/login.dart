import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tencent_cloud_chat_sdk_example/config.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  TextEditingController _useridController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initConfig();
  }

  void initConfig() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    _useridController.text = prefs.getString('userid') ?? '';
  }

  void login() async {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Login'),
        actions: [
          ElevatedButton(
              onPressed: () async {
                final SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();
              },
              child: const Text("clean config"))
        ],
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          TextField(
            controller: _useridController,
            decoration: const InputDecoration(labelText: "userid", hintText: "userid", prefixIcon: Icon(Icons.person)),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            child: const Text("登录"),
            onPressed: () async {
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('userid', _useridController.text);
              print("init sdk, login user: ${_useridController.text}");
              int code = await context.read<ListenerConfig>().initSDK();
              if (code == 0) {
                Navigator.pop(context);
              } else {
                prefs.clear();
                _useridController.text = "";
              }
            },
          ),
        ],
      )),
    ));
  }
}
