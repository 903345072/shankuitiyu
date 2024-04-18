import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/loading.dart';
import 'package:jingcai_app/util/rpx.dart';
import '../../widget/PreferredSizeWidget.dart';

import '../../widget/textWidget.dart';

class ManualCustomerServicePage extends StatefulWidget {
  const ManualCustomerServicePage({Key? key}) : super(key: key);

  @override
  State<ManualCustomerServicePage> createState() =>
      _ManualCustomerServicePageState();
}

class _ManualCustomerServicePageState extends State<ManualCustomerServicePage> {
  String? url;
  @override
  void initState() {
    super.initState();
    getewm();
  }

  getewm() {
    G.api.user.getKefuUrl({}).then((value) {
      setState(() {
        url = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('人工客服'),
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: rpx(80),
            ),
            const TextWidget(
              '您好，如遇到支付问题、不能查看推荐方案等问题，',
            ),
            SizedBox(
              height: 5.w,
            ),
            const TextWidget(
              '可以添加客服小编信号。',
            ),
            SizedBox(
              height: 5.w,
            ),
            const TextWidget(
              '客服小编上班时间9:00-23:00',
            ),
            SizedBox(
              height: rpx(30),
            ),
            Container(
              child: netImg(url, rpx(150), rpx(150)),
            ),
            SizedBox(
              height: rpx(40),
            ),
            TextWidget(
              '扫描二维码添加客服小编微信号',
              fontSize: rpx(16),
            ),
            SizedBox(
              height: rpx(40),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: rpx(40)),
              child: clickBtn('保存客服二维码', () async {
                final dio = Dio();
                final response = await dio.get(url!,
                    options: Options(responseType: ResponseType.bytes));

                final result = await ImageGallerySaver.saveImage(response.data);
                if (result['isSuccess']) {
                  tipSucess("保存成功");
                } else {
                  Loading.tip("uri1", "保存失败");
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> downloadImage() async {
    final dio = Dio();
    final response =
        await dio.get(url!, options: Options(responseType: ResponseType.bytes));

    final result = await ImageGallerySaver.saveImage(response.data);
    if (result['isSuccess']) {
      tipSucess("保存成功");
    } else {
      Loading.tip("uri1", "保存失败");
    }
  }
}
