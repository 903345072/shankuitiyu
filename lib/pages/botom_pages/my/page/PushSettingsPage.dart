import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../widget/PreferredSizeWidget.dart';

class PushSettingsPage extends StatefulWidget {
  const PushSettingsPage({Key? key}) : super(key: key);

  @override
  State<PushSettingsPage> createState() => _PushSettingsPageState();
}

class _PushSettingsPageState extends State<PushSettingsPage> {
  bool _switchnotificationEnabled = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('推送设置'),
      body: Container(
        margin: const EdgeInsets.only(top: 5),
        child: buildRowSwitch(
          '是否推送',
          CupertinoSwitch(
            value: _switchnotificationEnabled,
            activeColor: Colors.red,
            trackColor: Colors.black26,
            dragStartBehavior: DragStartBehavior.down,
            onChanged: (value) {
              _switchnotificationEnabled = value;
              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}
