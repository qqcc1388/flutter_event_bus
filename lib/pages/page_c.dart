import 'package:flutter/material.dart';
import 'package:flutter_event_bus/event_bus/event_bus_util.dart';
import 'package:flutter_event_bus/event_bus/event_login.dart';

class PageC extends StatefulWidget {
  @override
  _PageCState createState() => _PageCState();
}

class _PageCState extends State<PageC> with AutomaticKeepAliveClientMixin {
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
    print('C object initState');
    loginSuccessEvent = eventBus.on<LoginSuccessEvent>((event) {
      print('page C received loginSuccessEvent msg');
      //监听数据
      setState(() {
        params = event.userInfo;
      });
    });
    logoutEvent = eventBus.on<LogoutEvent>((event) {
      print('page C received logoutEvent msg');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('C')),
      body: Center(
        child: Text(params['c']),
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
