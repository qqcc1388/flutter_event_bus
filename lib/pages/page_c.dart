import 'package:flutter/material.dart';
import 'package:flutter_event_bus/event_bus/event_bus_util.dart';
import 'package:flutter_event_bus/event_bus/event_login_success.dart';

class PageC extends StatefulWidget {
  @override
  _PageCState createState() => _PageCState();
}

class _PageCState extends State<PageC> with AutomaticKeepAliveClientMixin {
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
    print('C object initState');
    loginSuccessEvent = eventBus.on((event) {
      print('page C received msg');
      //监听数据
      setState(() {
        params = event.userInfo;
      });
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
    super.dispose();
  }
}