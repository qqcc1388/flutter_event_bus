import 'package:flutter/material.dart';
import 'package:flutter_event_bus/event_bus/event_bus_util.dart';
import 'package:flutter_event_bus/event_bus/event_login.dart';

class PageE extends StatefulWidget {
  @override
  _PageEState createState() => _PageEState();
}

class _PageEState extends State<PageE> {
  var loginSuccessEvent;
  @override
  void initState() {
    loginSuccessEvent = eventBus.on<LoginSuccessEvent>((event) {
      print('page E received loginSuccessEvent msg');
      // print('object == ${event.userInfo}');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('E')),
      body: Center(
        child: FlatButton(
            onPressed: () {
              eventBus.emit(LoginSuccessEvent({
                'a': 'a101',
                'b': 'b201',
                'c': 'c301',
                'd': 'd401',
              }));
            },
            child: Text('点击发送消息')),
      ),
    );
  }

  @override
  void dispose() {
    eventBus.off(loginSuccessEvent);
    print('E object dispose');
    super.dispose();
  }
}
