import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/loading.dart';
import 'package:jingcai_app/util/rpx.dart';
import '../../widget/PreferredSizeWidget.dart';
import '../../widget/colors.dart';
import '../../widget/routes.dart';
import '../../widget/textWidget.dart';

class SharePage extends StatefulWidget {
  const SharePage({Key? key}) : super(key: key);

  @override
  State<SharePage> createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  String? url;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    G.api.user.getSharePic({}).then((value) {
      setState(() {
        url = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(89, 89, 89, 1),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: rpx(80)),
            padding: EdgeInsets.all(rpx(50)),
            child: netImg(url, rpx(250), rpx(380)),
          ),
          Positioned(
            top: rpx(30),
            left: rpx(20),
            child: onClick(
              Icon(Icons.navigate_before, color: MyColors.white, size: rpx(50)),
              () {
                Routes.popPage();
              },
            ),
          ),
          Container(
            width: double.infinity,
            color: MyColors.white,
            padding: EdgeInsets.all(rpx(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Column(
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     Image.asset(
                //       'assets/images/wx.png',
                //       width: rpx(50),
                //     ),
                //     SizedBox(
                //       height: 14.w,
                //     ),
                //     const TextWidget(
                //       '微信',
                //       color: MyColors.tip,
                //     ),
                //   ],
                // ),
                // Column(
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     Image.asset(
                //       'assets/images/wx.png',
                //       width: rpx(50),
                //     ),
                //     SizedBox(
                //       height: 14.w,
                //     ),
                //     const TextWidget(
                //       '朋友圈',
                //       color: MyColors.tip,
                //     ),
                //   ],
                // ),
                onClick(
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.save_alt),
                        SizedBox(
                          height: 14.w,
                        ),
                        const TextWidget(
                          '保存图片',
                          color: MyColors.tip,
                        ),
                      ],
                    ), () async {
                  final dio = Dio();
                  if (url == null) {
                    Loading.tip("uri2", "保存失败");
                    return;
                  }
                  final response = await dio.get(url!,
                      options: Options(responseType: ResponseType.bytes));

                  final result =
                      await ImageGallerySaver.saveImage(response.data);
                  if (result['isSuccess']) {
                    tipSucess("保存成功");
                  } else {
                    Loading.tip("uri2", "保存失败");
                  }
                }),
                // onClick(
                //     Column(
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         Image.asset(
                //           'assets/images/wx.png',
                //           width: rpx(50),
                //         ),
                //         SizedBox(
                //           height: 14.w,
                //         ),
                //         const TextWidget(
                //           '复制链接',
                //           color: MyColors.tip,
                //         ),
                //       ],
                //     ), () {
                //   Clipboard.setData(ClipboardData(text: url.toString())).then(
                //       (value) => Loading.tip("click", "复制成功",
                //           icon: Icons.tips_and_updates, color: Colors.green));
                // }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
