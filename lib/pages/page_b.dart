import 'package:flutter/material.dart';
import 'package:flutter_event_bus/event_bus/event_bus_util.dart';
import 'package:flutter_event_bus/event_bus/event_login.dart';

class PageB extends StatefulWidget {
  @override
  _PageBState createState() => _PageBState();
}

class _PageBState extends State<PageB> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  var loginSuccessEvent;
  var logoutEvent;
  Map params = {
    'a': 'a100',
    'b': 'b200',
    'c': 'c300',
    'd': 'd400',
  };
  @override
  void initState() {
    print('B object initState');
    loginSuccessEvent = eventBus.on<LoginSuccessEvent>((event) {
      print('page B received loginSuccessEvent msg');
      //监听数据
      setState(() {
        params = event.userInfo;
      });
    });
        logoutEvent = eventBus.on<LogoutEvent>((event) {
      print('page B received logoutEvent msg');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('B')),
      body: Center(
        child: Text(params['b']),
      ),
    );
  }

  @override
  void dispose() {
    eventBus.off(loginSuccessEvent);
    eventBus.off(logoutEvent);
    super.dispose();
  }
}
