import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widget/PreferredSizeWidget.dart';
import '../../widget/colors.dart';
import '../../widget/textWidget.dart';

class InformationProtectionSettingsPage extends StatefulWidget {
  const InformationProtectionSettingsPage({Key? key}) : super(key: key);

  @override
  State<InformationProtectionSettingsPage> createState() =>
      _InformationProtectionSettingsPageState();
}

class _InformationProtectionSettingsPageState
    extends State<InformationProtectionSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('个人信息保护设置'),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: const BoxDecoration(
              color: MyColors.white,
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: MyColors.grey_6f6,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const TextWidget(
                        '精准定位信息',
                        fontWeight: FontWeight.bold,
                        fontSize: 34,
                      ),
                      SizedBox(
                        height: 15.w,
                      ),
                      const TextWidget(
                          '关闭后，将不再收集您的GPS等精准位置信息，仅通过IP等定位大致的位置以保障基本的业务功能和用于安全风控。',
                          overflow: TextOverflow.visible,
                          maxLines: 3,
                          color: Colors.black87,
                          textAlign: TextAlign.left),
                    ],
                  ),
                ),
                SizedBox(
                  width: 30.w,
                ),
                const TextWidget(
                  '去设置>',
                  color: Colors.black87,
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: const BoxDecoration(
              color: MyColors.white,
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: MyColors.grey_6f6,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const TextWidget(
                        '相册',
                        fontWeight: FontWeight.bold,
                        fontSize: 34,
                      ),
                      SizedBox(
                        height: 15.w,
                      ),
                      const TextWidget(
                          '帮助你管理发布、保存、修改信息等功能。关闭后，将不能访问、读取相册、存储空间内的信息。',
                          overflow: TextOverflow.visible,
                          maxLines: 3,
                          color: Colors.black87,
                          textAlign: TextAlign.left),
                    ],
                  ),
                ),
                SizedBox(
                  width: 30.w,
                ),
                const TextWidget(
                  '去设置>',
                  color: Colors.black87,
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: const BoxDecoration(
              color: MyColors.white,
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: MyColors.grey_6f6,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const TextWidget(
                        '相机',
                        fontWeight: FontWeight.bold,
                        fontSize: 34,
                      ),
                      SizedBox(
                        height: 15.w,
                      ),
                      const TextWidget('帮助你管理、授权通过拍摄等方式收集照片信息。关闭后，将不能采集照片信息。',
                          overflow: TextOverflow.visible,
                          maxLines: 3,
                          color: Colors.black87,
                          textAlign: TextAlign.left),
                    ],
                  ),
                ),
                SizedBox(
                  width: 30.w,
                ),
                const TextWidget(
                  '去设置>',
                  color: Colors.black87,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
