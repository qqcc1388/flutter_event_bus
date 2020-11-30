import 'package:flutter/material.dart';
import 'package:flutter_event_bus/event_bus/event_bus_util.dart';
import 'package:flutter_event_bus/event_bus/event_login.dart';
import 'package:flutter_event_bus/pages/page_e.dart';

class PageA extends StatefulWidget {
  @override
  _PageAState createState() => _PageAState();
}

class _PageAState extends State<PageA> with AutomaticKeepAliveClientMixin {
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
    print('A object initState');
    loginSuccessEvent = eventBus.on<LoginSuccessEvent>((event) {
      print('page A received loginSuccessEvent msg');
      setState(() {
        params = event.userInfo;
      });
    });
    logoutEvent = eventBus.on<LogoutEvent>((event) {
      print('page A received logoutEvent msg');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('A')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                onPressed: () {
                  //跳转到下一页
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (
                        context,
                      ) =>
                              PageE()));
                },
                child: Text('点击进入下一页'),
              ),
              FlatButton(
                onPressed: () {
                  eventBus.emit(LoginSuccessEvent({
                    'a': 'a101',
                    'b': 'b201',
                    'c': 'c301',
                    'd': 'd401',
                  }));
                },
                child: Text('点击发送loginSuccess消息'),
              ),
              FlatButton(
                      onPressed: () {
                  eventBus.emit(LogoutEvent());
                },
                child: Text('点击发送logout消息'),
              ),
              Text(params['a']),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    eventBus.off(loginSuccessEvent);
    eventBus.off(logoutEvent);
    super.dispose();
  }
}
