import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'colors.dart';
import 'textWidget.dart';

AppBar appbar(String title, {TabBar? bottom, List<Widget>? actions}) {
  return AppBar(
      title: TextWidget(
        title,
        fontSize: rpx(16),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      foregroundColor: Colors.black,
      bottom: bottom,
      actions: actions);
}

AppBar appbarWithLeading(String title,
    {TabBar? bottom, List<Widget>? actions, required Widget leading}) {
  return AppBar(
      title: TextWidget(
        title,
        fontSize: rpx(16),
      ),
      centerTitle: true,
      leading: leading,
      backgroundColor: Colors.white,
      elevation: 0,
      foregroundColor: Colors.black,
      bottom: bottom,
      actions: actions);
}

GestureDetector onClick(Widget widget, Function() fun) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    child: widget,
    onTap: fun,
  );
}

Widget buildRow(String title, Function() fun,
    {String? text, Widget? widget, Widget? rightIcon}) {
  return GestureDetector(
    behavior: HitTestBehavior.translucent,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: (10), vertical: 16),
      decoration: const BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 1, color: Color(0xFFF6F6F6)))),
      child: Row(
        children: <Widget>[
          TextWidget(
            title,
            color: MyColors.black_33,
          ),
          Expanded(
            child: widget ??
                TextWidget(
                  text ?? '',
                  textAlign: TextAlign.end,
                  color: MyColors.grey_99,
                ),
          ),
          const SizedBox(width: 9),
          rightIcon ??
              Image.asset(
                'assets/images/d1_gengduo.png',
                width: rpx(15),
              )
        ],
      ),
    ),
    onTap: fun,
  );
}

Widget buildRowSwitch(String title, Widget widget) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8),
    decoration: const BoxDecoration(
        color: MyColors.white,
        border: Border(bottom: BorderSide(width: 1, color: MyColors.grey_6f6))),
    child: Row(
      children: <Widget>[
        TextWidget(
          title,
          color: MyColors.black_33,
        ),
        const Spacer(),
        widget
      ],
    ),
  );
}

Widget clickBtn(String title, Function() fun) {
  return GestureDetector(
    child: Container(
      width: 500.w,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: TextWidget(
        title,
        color: Colors.white,
        fontSize: rpx(15),
      ),
    ),
    onTap: fun,
  );
}

Widget disableBtn(String title, Function() fun) {
  return GestureDetector(
    child: Container(
      width: 500.w,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: TextWidget(
        title,
        color: Colors.white,
        fontSize: rpx(15),
      ),
    ),
    onTap: fun,
  );
}

clickShowModalBottomSheet(context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context1) {
      return Container(
        color: MyColors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: const TextWidget('拍照', color: MyColors.black_32),
              onTap: () async {},
            ),
            Container(
              height: 1,
              color: MyColors.grey_6f6,
            ),
            ListTile(
              title: const TextWidget("从相册选择", color: MyColors.black_32),
              onTap: () async {},
            ),
            Container(
              height: 10.w,
              color: MyColors.grey_6f6,
            ),
            Container(
              decoration: const BoxDecoration(color: MyColors.white),
              child: ListTile(
                title: const TextWidget('取消', color: MyColors.black_32),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      );
    },
  );
}

uploadPic(context, Function dd) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context1) {
      return Container(
        color: MyColors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 1,
              color: MyColors.grey_6f6,
            ),
            ListTile(
              title: TextWidget(
                '拍照',
                color: MyColors.black_32,
                fontSize: rpx(14),
              ),
              onTap: () async {
                final ImagePicker _picker = ImagePicker();
                // 使用相机拍摄新照片
                final XFile? photo =
                    await _picker.pickImage(source: ImageSource.camera);

                if (photo != null) {
                  // 使用拍摄的照片
                  dd(photo);
                }
                G.router.pop(context);
              },
            ),
            Container(
              height: 1,
              color: MyColors.grey_6f6,
            ),
            ListTile(
              title: TextWidget(
                "从相册选择",
                color: MyColors.black_32,
                fontSize: rpx(14),
              ),
              onTap: () async {
                final ImagePicker _picker = ImagePicker();
                // 从图库选择图片
                final XFile? image =
                    await _picker.pickImage(source: ImageSource.gallery);

                if (image != null) {
                  // 使用选择的图片
                  dd(image);
                }
                G.router.pop(context);
              },
            ),
            Container(
              height: 5.w,
              color: MyColors.grey_6f6,
            ),
            Container(
              decoration: const BoxDecoration(color: MyColors.white),
              child: ListTile(
                title: TextWidget(
                  '取消',
                  color: MyColors.black_32,
                  fontSize: rpx(14),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      );
    },
  );
}
