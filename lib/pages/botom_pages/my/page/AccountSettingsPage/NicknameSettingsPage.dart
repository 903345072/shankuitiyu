import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/loading.dart';

import '../../../widget/PreferredSizeWidget.dart';
import '../../../widget/colors.dart';

class NicknameSettingsPage extends StatefulWidget {
  String? name;
  Function dd;
  NicknameSettingsPage({Key? key, required this.name, required this.dd})
      : super(key: key);

  @override
  State<NicknameSettingsPage> createState() => _NicknameSettingsPageState();
}

class _NicknameSettingsPageState extends State<NicknameSettingsPage> {
  final TextEditingController _newNameEC = TextEditingController();

  @override
  void initState() {
    if (widget.name != null) {
      _newNameEC.text = widget.name!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar('昵称设置'),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10.w),
              padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
              color: MyColors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _newNameEC,
                      autofocus: false,
                      decoration: const InputDecoration(
                        labelStyle:
                            TextStyle(fontSize: 16, color: MyColors.black_33),
                        hintText: '',
                        hintStyle:
                            TextStyle(fontSize: 16, color: MyColors.grey_99),
                        border: InputBorder.none,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 100.w,
            ),
            clickBtn('修改', () {
              G.api.user.setName({"name": _newNameEC.value.text}).then((value) {
                if (value == "yes") {
                  Loading.tip("uri", "修改成功", icon: Icons.tips_and_updates);
                }

                widget.dd(_newNameEC.value.text);
              });
            }),
          ],
        ));
  }
}
