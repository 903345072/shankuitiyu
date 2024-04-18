import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/loading.dart';
import 'package:jingcai_app/util/rpx.dart';

import '../../widget/InputWidget.dart';
import '../../widget/PreferredSizeWidget.dart';
import '../../widget/colors.dart';
import '../../widget/textWidget.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  String content = "";
  String phone = "";
  String email = "";
  List<File> imgs = [];
  bool can_click = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('提交反馈信息'),
      body: ListView(
        children: [
          SizedBox(
            height: 10.w,
          ),
          _textFieldW(),
          addPhoto(),
          SizedBox(
            height: 10.w,
          ),
          Container(
            padding: EdgeInsets.all(10.w),
            color: MyColors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextWidget(
                  '联系电话',
                ),
                InputWidget(
                  hintText: '选填，便于我们联系您...',
                  hintStyle: const TextStyle(color: MyColors.tip, fontSize: 16),
                  onChanged: (String? value) {
                    setState(() {
                      phone = value!;
                    });
                  },
                  textStyle:
                      const TextStyle(color: MyColors.black_33, fontSize: 16),
                ),
                const Divider(
                  height: 1.5,
                  color: MyColors.grey_e8,
                ),
                SizedBox(
                  height: 20.w,
                ),
                const TextWidget(
                  '邮箱地址',
                ),
                InputWidget(
                  hintText: '选填，便于我们联系您...',
                  hintStyle: const TextStyle(color: MyColors.tip, fontSize: 16),
                  onChanged: (String? value) {
                    setState(() {
                      email = value!;
                    });
                  },
                  textStyle:
                      const TextStyle(color: MyColors.black_33, fontSize: 16),
                ),
              ],
            ),
          ),
          Container(
            color: MyColors.white,
            alignment: Alignment.center,
            height: rpx(60),
            margin: EdgeInsets.symmetric(horizontal: rpx(30)),
            child: can_click
                ? clickBtn('提交反馈', () {
                    if (content.toString().isEmpty) {
                      Loading.tip("uridd", "请输入完整信息");
                      return;
                    }
                    setState(() {
                      can_click = false;
                    });
                    Map<String, dynamic> m = {
                      "content": content,
                      "phone": phone,
                      "email": email,
                      "img": imgs
                    };
                    G.api.user.submitFeedBack(m).then((value) {
                      if (value != "ok") {
                        setState(() {
                          can_click = true;
                        });

                        return;
                      }
                      tipSucess("提交成功");
                    });
                  })
                : disableBtn('提交反馈', () {}),
          )
        ],
      ),
    );
  }

  Widget _textFieldW() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Color(0xFFF6F6F6),
          ),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      height: rpx(200),
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
      child: TextField(
        autofocus: false,
        minLines: 6,
        maxLines: 10,
        maxLength: 500,
        onChanged: (String? value) {
          setState(() {
            content = value!;
          });
        },
        decoration: InputDecoration(
          labelStyle: TextStyle(fontSize: 16, color: MyColors.black_33),
          hintText: '请输入10个字以上的问题描述或建议，不超过500字...',
          hintStyle: TextStyle(fontSize: 16, color: MyColors.grey_99),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget addPhoto() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: rpx(10)),
      padding: EdgeInsets.all(rpx(10)),
      child: Wrap(
        spacing: rpx(10),
        runSpacing: rpx(10),
        children: [
          Wrap(
            spacing: rpx(10),
            runSpacing: rpx(10),
            children: List.generate(
                imgs.length,
                (index) => Stack(
                      children: [
                        Image.file(
                          imgs[index],
                          width: rpx(100),
                          height: rpx(100),
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                            top: rpx(5),
                            right: rpx(5),
                            child: onClick(
                                Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ), () {
                              setState(() {
                                imgs.removeAt(index);
                              });
                            }))
                      ],
                    )),
          ),
          onClick(
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: rpx(1),
                        color: const Color.fromARGB(255, 233, 233, 233))),
                width: rpx(100),
                height: rpx(100),
                child: Icon(
                  Icons.add,
                  size: rpx(80),
                  color: Color.fromARGB(255, 233, 233, 233),
                  weight: 1,
                ),
              ), () {
            uploadPic(context, (XFile e) {
              setState(() {
                imgs.add(File(e.path));
              });
            });
          })
        ],
      ),
    );
  }
}
