import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';

import '../../../widget/PreferredSizeWidget.dart';
import '../../../widget/colors.dart';

class AvatarSettingsPage extends StatefulWidget {
  String? url;
  Function dd;
  AvatarSettingsPage({Key? key, required this.url, required this.dd})
      : super(key: key);

  @override
  State<AvatarSettingsPage> createState() => _AvatarSettingsPageState();
}

class _AvatarSettingsPageState extends State<AvatarSettingsPage> {
  File? img;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('头像设置'),
      body: Container(
        alignment: Alignment.center,
        color: MyColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(rpx(80)),
              alignment: Alignment.center,
              width: rpx(150),
              height: rpx(150),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  rpx(150),
                ),
                child: netImg(
                  widget.url,
                  rpx(150),
                  rpx(150),
                ),
              ),
            ),
            clickBtn('更换头像', () {
              uploadPic(context, (XFile e) {
                img = File(e.path);
                G.api.user.setAvatar({"path": e.path}).then((value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      widget.url = value;
                    });
                    widget.dd(value);
                  }
                });
              });
            }),
          ],
        ),
      ),
    );
  }
}
