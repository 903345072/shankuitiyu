import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:jingcai_app/components/BottomTabBar/TabNavigationWidget.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/botom_pages/bigData.dart';
import 'package:jingcai_app/pages/botom_pages/community.dart';
import 'package:jingcai_app/pages/botom_pages/home.dart';
import 'package:jingcai_app/pages/botom_pages/my/MyPage.dart';
import 'package:jingcai_app/pages/botom_pages/my/page/ApplicationInfluencerPage.dart';
import 'package:jingcai_app/pages/botom_pages/score.dart';
import 'package:jingcai_app/pages/botom_pages/widget/NavigatorKey.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/pages/pushBf.dart';

import 'package:jingcai_app/routes/routes.dart';
import 'package:jingcai_app/util/loading.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'util/G.dart';

void main() {
  FluroRouter router = FluroRouter();
  Routes.configureRoutes(router);
  G.router = router;

  runApp(const MyApp());
}

getPerMission() async {
  print("平台");
  print(Platform.isIOS);
  if (Platform.isIOS) {
    print("开始授权");
    var sd = await Permission.location.request().isGranted;

    if (sd) {
      print("授权成功");
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initScreenUtil(context);

    return MaterialApp(
      navigatorKey: NavigatorKey.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  PageController _pageController = PageController(initialPage: 0);
  AudioPlayer? _audioPlayer;
  int _currentIndex = 0;
  AnimationController? _controller;
  List my_flows = [];
  bool sound_on = true;
  bool flow_on = false;
  Animation<Offset>? _offsetAnimation;
  final List<Widget> _pageList = [
    Home(),
    score(),
    community(),
    bigData(),
    MyPage()
  ];

  WebSocketChannel? _channel;

  Timer? _heartbeatTimer;
  Timer? _reconnerctTimer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0, 1), // 开始时从屏幕底部外开始

      end: Offset(0, 0.5), // 向左偏移一个屏幕宽度
    ).animate(_controller!);
    _audioPlayer = AudioPlayer();
    getState();
    connectToWebSocket();
  }

  getState() {
    G.api.user.getSettingState({}).then((value) async {
      setState(() {
        flow_on = value["flow_on"] == 1 ? true : false;
        sound_on = value["sound_on"] == 1 ? true : false;
        my_flows = value["flows"];
      });
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setBool("flow_on", flow_on);
      sharedPreferences.setBool("sound_on", sound_on);
      List<String> sr = my_flows.map((e) {
        return e.toString();
      }).toList();
      sharedPreferences.setStringList("flows", sr);
    });
  }

  void displayOverlayMessage(BuildContext context, JcFootModel foot) {
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        right: -300,
        bottom: 80,
        width: 300,
        child: SlideTransition(
            position: _offsetAnimation!, child: pushBf(foot: foot)),
      ),
    );

    Overlay.of(context).insert(overlayEntry);
    _controller!.forward();
    // 指定时间后移除 Overlay
    Future.delayed(Duration(seconds: 3), () {
      _controller!.reverse();
      overlayEntry.remove();
    });
  }

  void showMessageOverlay(JcFootModel foot) {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
        bottom: rpx(150),
        right: 0,
        left: 0,
        child: Material(
          color: Colors.transparent,
          child: SlideTransition(
              position: _offsetAnimation!, child: pushBf(foot: foot)),
        ),
      ),
    );
    overlayState.insert(overlayEntry);
    _controller!.forward();
    // 3秒后自动移除Overlay
    Future.delayed(Duration(seconds: 3)).then((_) {
      _controller!.reverse();
      overlayEntry.remove();
    });
  }

  Future _playLocalSound() async {
    return await _audioPlayer!.play(AssetSource("music/hecai.mp3"));
  }

  void connectToWebSocket() async {
    try {
      _channel =
          WebSocketChannel.connect(Uri.parse('ws://47.122.18.242:85?id=1'));

      _channel!.stream.listen(
        (message) async {
          Map<String, dynamic> d = jsonDecode(message);
          if (d.containsValue("ping")) {
          } else {
            JcFootModel j = JcFootModel.fromJson(d);
            // 处理接收到的消息12
            if (j.leagues != null) {
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              bool? flow_on = sharedPreferences.getBool("flow_on");
              bool? sound_on = sharedPreferences.getBool("sound_on");
              List<String>? flows = sharedPreferences.getStringList("flows");
              if (flow_on!) {
                if (flows!.contains(j.id.toString())) {
                  if (sound_on!) {
                    _playLocalSound();
                  }
                  showMessageOverlay(j);
                }
              } else {
                if (sound_on!) {
                  _playLocalSound();
                }
                showMessageOverlay(j);
              }
            }
          }
        },
        onError: (error) {
          // 处理错误
          print(error.toString());
          // Loading.tip("uriw", error.toString());
          reconnect(); // 可以在这里实现重连逻辑
        },
        onDone: () {
          // 连接关闭时的处理

          print('WebSocket closed');

          reconnect(); // 可以在这里实现重连逻辑
        },
        cancelOnError: true,
      );
      if (_reconnerctTimer != null) {
        _reconnerctTimer!.cancel();
        _reconnerctTimer = null;
      }

      startHeartbeat();
    } catch (e) {
      print('WebSocket connection failed: $e');

      reconnect(); // 可以在这里实现重连逻辑
    }
  }

  void startHeartbeat() {
    // 每30秒发送一次心跳包

    _heartbeatTimer = Timer.periodic(Duration(seconds: 10), (timer) {
      if (_channel != null) {
        // print("发送细条");
        _channel!.sink.add('heartbeat'); // 发送心跳包，这里可以根据你的协议发送特定的心跳消息
      } else {
        // 如果连接未打开，可以取消定时器或尝试重连

        timer.cancel();
      }
    });
  }

  void stopHeartbeat() {
    _heartbeatTimer?.cancel();
  }

  void reconnect() {
    // 停止当前的心跳定时器

    stopHeartbeat();

    // 等待一段时间后重连

    _reconnerctTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      //  print("重连中");
      connectToWebSocket();
    });
  }

  @override
  Widget build(BuildContext context) {
    Loading.ctx = context;

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: _pageList,
      ),
//
      bottomNavigationBar: Wrap(
        children: [
          TabNavigationWidget(
            (v) {
              setState(() {
                _currentIndex = v;
                _pageController.jumpToPage(_currentIndex);
              });
            },
          ),
          Container(
            height: MediaQuery.of(context).padding.bottom,
            color: Colors.white,
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
