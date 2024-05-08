import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widget/PreferredSizeWidget.dart';

class GoalReminderSettingsPage extends StatefulWidget {
  const GoalReminderSettingsPage({Key? key}) : super(key: key);

  @override
  State<GoalReminderSettingsPage> createState() =>
      _GoalReminderSettingsPageState();
}

class _GoalReminderSettingsPageState extends State<GoalReminderSettingsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getState();
  }

  getState() {
    G.api.user.getSettingState({}).then((value) {
      setState(() {
        flow_on = value["flow_on"] == 1 ? true : false;
        sound_on = value["sound_on"] == 1 ? true : false;
      });
    });
  }

  bool flow_on = false;
  bool sound_on = true;
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
                  value: flow_on,
                  activeColor: Colors.red,
                  trackColor: Colors.black26,
                  dragStartBehavior: DragStartBehavior.down,
                  onChanged: (value) async {
                    flow_on = value;
                    setState(() {});
                    G.api.user.settingState({"flow_on": flow_on ? 1 : 0});
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.setBool("flow_on", flow_on);
                  },
                ),
              ),
              buildRowSwitch(
                '声音',
                CupertinoSwitch(
                  value: sound_on,
                  activeColor: Colors.red,
                  trackColor: Colors.black26,
                  dragStartBehavior: DragStartBehavior.down,
                  onChanged: (value) async {
                    sound_on = value;
                    setState(() {});
                    G.api.user.settingState({"sound_on": sound_on ? 1 : 0});
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.setBool("sound_on", sound_on);
                  },
                ),
              ),
            ],
          )),
    );
  }
}
