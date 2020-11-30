# flutter_event_bus

flutter中可以是用event_bus来消息通知
event_bus使用的是[event_bus](https://pub.dev/packages/event_bus) https://pub.dev/packages/event_bus 这个库，这里只介绍如果使用该plugin，以及在使用的时候遇到的一些问题

本例demo下载地址：https://github.com/qqcc1388/flutter_event_bus

官方给出的使用方法：
```
创建消息对象
class UserLoggedInEvent {
  User user;

  UserLoggedInEvent(this.user);
}

创建eventBus
EventBus eventBus = EventBus();

注册订阅 这里可以将保存下来 dispose可以将该stream移除订阅
StreamSubscription loginSubscription = eventBus.on<UserLoggedInEvent>().listen((event) {
  // All events are of type UserLoggedInEvent (or subtypes of it).
  print(event.user);
});


eventBus.on<UserLoggedInEvent>().listen((event) {
  // All events are of type UserLoggedInEvent (or subtypes of it).
  print(event.user);
});

发送消息
User user = {}; 
eventBus.fire(UserLoggedInEvent(user));

移除eventBus
  @override
  void dispose() {
    loginSubscription.cancel();
    super.dispose();
  }
```
主要注意的是 添加过订阅后 一定要将订阅steam移除，否则，页面计算被移除，仍然可以接收到订阅消息，造成内存泄漏

基于官方给的使用方法，对eventbus做了一层封装，方便在项目中使用

```
import 'dart:async';
import 'package:event_bus/event_bus.dart';

typedef void EventCallback(event);

class EventBusUtils {
  factory EventBusUtils() => _getInstance();
  static EventBusUtils get instance => _getInstance();
  static EventBusUtils _instance;
  EventBusUtils._internal() {
    // 初始化
    _eventBus = new EventBus();
  }

  //初始化eventBus
  EventBus _eventBus;
  // EventBus get eventBus => _eventBus;

  /// 订阅stream列表
  // List<StreamSubscription> subscriptionList;

  static EventBusUtils _getInstance() {
    if (_instance == null) {
      _instance = new EventBusUtils._internal();
    }
    return _instance;
  }

  /// 开启eventbus订阅 并
  StreamSubscription on<T>(EventCallback callback) {
    StreamSubscription stream = _eventBus.on<T>().listen((event) {
      callback(event);
    });
    // subscriptionList.add(stream);
    return stream;
  }

  /// 发送消息
  void emit(event) {
    _eventBus.fire(event);
    
  }

  /// 移除steam
  void off(StreamSubscription steam) {
    steam.cancel();
  }
}

var eventBus = EventBusUtils.instance;

```

使用起来很很简单
```
 var loginSuccessEvent;
  添加订阅
  loginSuccessEvent = eventBus.on((event) {
    print('page A received msg');
    setState(() {
      params = event.userInfo;
    });
  });

 发送消息订阅
 User user = {};
 eventBus.emit(UserLoggedInEvent(user));

  取消订阅
   @override
  void dispose() {
    eventBus.off(loginSuccessEvent);
    super.dispose();
  }

```
封装之后，使用变的简化了

需要注意一点的是在使用event_bus的时候不要调用destroy()方法，否则将无法收到消息监听，如果要移除订阅，请使用 stream.cancel();


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
