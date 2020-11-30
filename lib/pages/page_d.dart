import 'package:flutter/material.dart';
import 'package:flutter_event_bus/event_bus/event_bus_util.dart';

class PageD extends StatefulWidget {
  @override
  _PageDState createState() => _PageDState();
}

class _PageDState extends State<PageD> with AutomaticKeepAliveClientMixin {
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
    print('D object initState');
    loginSuccessEvent = eventBus.on((event) {
      print('page D received msg');
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
      appBar: AppBar(title: Text('D')),
      body: Center(child: Text(params['d'])),
    );
  }

  @override
  void dispose() {
    eventBus.off(loginSuccessEvent);

    super.dispose();
  }
}
