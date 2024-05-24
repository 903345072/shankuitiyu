import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widget/InputWidget.dart';
import '../../widget/PreferredSizeWidget.dart';
import '../../widget/colors.dart';
import '../../widget/routes.dart';
import '../../widget/textWidget.dart';
import 'SubmitProposalInformationPage.dart';

class SubmitExpertInformationPage extends StatefulWidget {
  const SubmitExpertInformationPage({Key? key}) : super(key: key);

  @override
  State<SubmitExpertInformationPage> createState() =>
      _SubmitExpertInformationPageState();
}

class _SubmitExpertInformationPageState
    extends State<SubmitExpertInformationPage> {
  String src = "assets/images/default_head.png";
  File? file;
  String name = "";
  String introduce = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyColors.white,
      appBar: appbarWithLeading('提交专家信息',
          leading: IconButton(
              onPressed: () async {
                G.router.pop(context);
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.remove("plan1");
                sharedPreferences.remove("plan2");
              },
              icon: Icon(Icons.arrow_back_ios))),
      body: Container(
        padding: EdgeInsets.all(10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              '头像',
              fontSize: rpx(16),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                uploadPic(context, (XFile e) {
                  setState(() {
                    this.src = e.path;
                    this.file = File(e.path);
                  });
                });
              },
              child: Container(
                alignment: Alignment.centerRight,
                width: rpx(50),
                height: rpx(50),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.w),
                  child: file != null
                      ? Image.file(
                          file!,
                          width: rpx(50),
                          height: rpx(50),
                          fit: BoxFit.cover,
                        )
                      : Container(
                          alignment: Alignment.center,
                          width: rpx(50),
                          height: rpx(50),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 228, 227, 227)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: TextWidget(
                            "未选择",
                            fontSize: rpx(12),
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextWidget(
              '头像不可含有微信号、二维码等引流信息',
              color: MyColors.tip,
              fontSize: rpx(14),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              height: 1.5,
              color: MyColors.grey_e8,
            ),
            const SizedBox(
              height: 10,
            ),
            TextWidget(
              '达人标签',
              fontSize: rpx(14),
            ),
            InputWidget(
              hintText: '名称不可含有敏感词、引流信息等',
              hintStyle: TextStyle(color: MyColors.tip, fontSize: rpx(14)),
              textStyle: TextStyle(color: MyColors.black_33, fontSize: rpx(14)),
              inputFormatters: [LengthLimitingTextInputFormatter(6)],
              onChanged: (s) {
                name = s;
              },
            ),
            const Divider(
              height: 1.5,
              color: MyColors.grey_e8,
            ),
            const SizedBox(
              height: 10,
            ),
            TextWidget(
              '简介',
              fontSize: rpx(14),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: rpx(200),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1,
                  color: const Color(0xFFF6F6F6),
                ),
              ),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
              child: TextField(
                autofocus: false,
                minLines: 8,
                maxLines: 12,
                maxLength: 100,
                onChanged: (s) {
                  setState(() {
                    introduce = s;
                  });
                },
                decoration: InputDecoration(
                  labelStyle:
                      TextStyle(fontSize: rpx(14), color: MyColors.black_33),
                  hintText:
                      '1、最少20个字，最多100字；\n2、含有引流信息、行业敏感词等；\n3、简介内容最好体现自己擅长的赛事领域。\n4、规避敏感词违禁词（类似最、第一之类）、过分的吹嘘战绩，过分夸大自己也将审核不过。',
                  hintStyle:
                      TextStyle(fontSize: rpx(14), color: MyColors.grey_99),
                  border: InputBorder.none,
                ),
              ),
            ),
            const Spacer(),
            Container(
              alignment: Alignment.center,
              child: name.length >= 2 && introduce.length >= 20
                  ? clickBtn('下一步', () {
                      Routes.pushPage(SubmitProposalInformationPage(
                        file: file,
                        name: name,
                        intro: introduce,
                      ));
                    })
                  : disableBtn('下一步', () => null),
            ),
          ],
        ),
      ),
    );
  }
}
