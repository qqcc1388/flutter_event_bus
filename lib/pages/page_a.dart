import 'package:flutter/material.dart';
import 'package:flutter_event_bus/event_bus/event_bus_util.dart';
import 'package:flutter_event_bus/event_bus/event_login_success.dart';
import 'package:flutter_event_bus/pages/page_e.dart';

class PageA extends StatefulWidget {
  @override
  _PageAState createState() => _PageAState();
}

class _PageAState extends State<PageA> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  var loginSuccessEvent;

  Map params = {
    'a': 'a100',
    'b': 'b200',
    'c': 'c300',
    'd': 'd400',
  };
  @override
  void initState() {
    print('A object initState');
    loginSuccessEvent = eventBus.on((event) {
      print('page A received msg');
      setState(() {
        params = event.userInfo;
      });
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
                child: Text('点击发送消息'),
              ),
              Text(params['a']),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    eventBus.off(loginSuccessEvent);
    super.dispose();
  }
}
