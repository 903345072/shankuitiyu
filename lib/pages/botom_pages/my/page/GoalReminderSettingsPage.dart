import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../widget/PreferredSizeWidget.dart';

class GoalReminderSettingsPage extends StatefulWidget {
  const GoalReminderSettingsPage({Key? key}) : super(key: key);

  @override
  State<GoalReminderSettingsPage> createState() =>
      _GoalReminderSettingsPageState();
}

class _GoalReminderSettingsPageState extends State<GoalReminderSettingsPage> {
  bool _switchnotificationEnabled = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('进球提醒设置'),
      body: Container(
          margin: const EdgeInsets.only(top: 5),
          child: Column(
            children: [
              buildRowSwitch(
                '仅提示我关注的',
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
              buildRowSwitch(
                '声音',
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
              buildRowSwitch(
                '震动',
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
            ],
          )),
    );
  }
}
