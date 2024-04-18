import 'dart:convert';
import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jingcai_app/components/daxiaoPublishPlanFactory.dart';
import 'package:jingcai_app/components/dxfPublishPlanFactory.dart';
import 'package:jingcai_app/components/gameTitle.dart';
import 'package:jingcai_app/components/jcFootPlanWidget.dart';
import 'package:jingcai_app/components/jcFootPublishPlanFactory.dart';
import 'package:jingcai_app/components/publishPlanFactory.dart';
import 'package:jingcai_app/components/rfsfPublishPlanFactory.dart';

import 'package:jingcai_app/components/rqPublishPlanFactory.dart';
import 'package:jingcai_app/enum/planType.dart';
import 'package:jingcai_app/model/PlanModel.dart';
import 'package:jingcai_app/model/jcFootMetModel.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/model/jcFootPlModel.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/loading.dart';
import 'package:jingcai_app/util/rpx.dart';
import '../../widget/InputWidget.dart';
import '../../widget/PreferredSizeWidget.dart';
import '../../widget/colors.dart';
import '../../widget/routes.dart';
import '../../widget/textWidget.dart';
import 'SubmitProposalInformationPage.dart';

class publish extends StatefulWidget {
  PlanModel? planModel;
  String type;
  publish({Key? key, required this.type, this.planModel}) : super(key: key);

  @override
  State<publish> createState() => _SubmitExpertInformationPageState();
}

class _SubmitExpertInformationPageState extends State<publish> {
  String src = "assets/images/default_head.png";
  File? file;
  String title = "";
  String introduce = "";
  String desc = "";
  List<JcFootModel> jcFootList = [];
  List<JcFootModel> checkFootList = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController introduceController = TextEditingController();
  TextEditingController descController = TextEditingController();
  List<File> imgs = [];
  bool is_add = true;
  Map<String, publishPlanFactory> map = {
    planType.jcFoot.value: jcFootPublishPlanFactory(),
    planType.rq.value: rqPublishPlanFactory(),
    planType.daxiaoqiu.value: daxiaoPublishPlanFactory(),
    planType.rfsf.value: rfsfPublishPlanFactory(),
    planType.dxf.value: dxfPublishPlanFactory(),
  };

  @override
  void initState() {
    super.initState();

    if (widget.planModel != null) {
      setState(() {
        title = widget.planModel!.title!;
        titleController.text = title;
        introduce = widget.planModel!.introduce!;
        introduceController.text = introduce;
        desc = widget.planModel!.desc!;
        descController.text = desc;
        introduce = widget.planModel!.introduce!;
        desc = widget.planModel!.desc!;
        checkFootList = widget.planModel!.footmodel!;
        imgs = widget.planModel!.files!.map((e) => File(e)).toList();
      });
    }
    getData();
  }

  getData() async {
    if (widget.type == planType.jcFoot.value) {
      await G.api.game.getJcFootList().then((value) {
        setState(() {
          jcFootList = value;
        });
      });
    }

    if (widget.type == planType.rq.value ||
        widget.type == planType.daxiaoqiu.value) {
      await G.api.game.getrQFootList().then((value) {
        setState(() {
          jcFootList = value;
        });
      });
    }

    if (widget.type == planType.rfsf.value ||
        widget.type == planType.dxf.value) {
      await G.api.game.getBaketList({"type": widget.type}).then((value) {
        setState(() {
          jcFootList = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyColors.white,
      appBar: appbar('发布方案'),
      body: Container(
        alignment: Alignment.bottomLeft,
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(left: rpx(10)),
              child: TextWidget(
                '标题(必填)',
                fontSize: rpx(14),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: rpx(10)),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
              height: rpx(100),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1,
                  color: const Color(0xFFF6F6F6),
                ),
              ),
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: titleController,
                autofocus: false,
                minLines: 8,
                maxLines: 12,
                maxLength: 40,
                onChanged: (s) {
                  setState(() {
                    title = s;
                  });
                },
                decoration: InputDecoration(
                  labelStyle:
                      TextStyle(fontSize: rpx(14), color: MyColors.black_33),
                  hintText: '限制在40个字以内；不得出现违反国家价值观，诱导性、煽动性、承诺性等类型的词汇。',
                  hintStyle:
                      TextStyle(fontSize: rpx(14), color: MyColors.grey_99),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: rpx(10)),
              child: Wrap(
                spacing: 15,
                children: [
                  TextWidget(
                    '筛选比赛',
                    fontSize: rpx(14),
                    textAlign: TextAlign.left,
                  ),
                  TextWidget(
                    '例如: 欧冠  皇马',
                    fontSize: rpx(14),
                    textAlign: TextAlign.left,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            getPlanList(),
            widget.type == planType.jcFoot.value || checkFootList.isEmpty
                ? onClick(
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: rpx(10)),
                      alignment: Alignment(0, 0),
                      height: rpx(40),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: const Color.fromARGB(255, 235, 235, 235))),
                      child: TextWidget(
                        checkFootList.isEmpty ? '+添加比赛' : '+添加比赛(再添加比赛为串关)',
                        fontSize: rpx(14),
                        color: Colors.red,
                      ),
                    ), () {
                    setState(() {
                      is_add = true;
                    });
                    show(-1);
                  })
                : Container(),
            const SizedBox(
              height: 10,
            ),
            TextWidget(
              '   引文(选填)',
              fontSize: rpx(14),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: rpx(240),
              margin: EdgeInsets.symmetric(horizontal: rpx(10)),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 25),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1,
                  color: const Color(0xFFF6F6F6),
                ),
              ),
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: introduceController,
                autofocus: false,
                minLines: 8,
                maxLines: 12,
                maxLength: 300,
                onChanged: (s) {
                  setState(() {
                    introduce = s;
                  });
                },
                decoration: InputDecoration(
                  labelStyle:
                      TextStyle(fontSize: rpx(14), color: MyColors.black_33),
                  hintText:
                      '1.引文内容付费前不屏蔽，用户可查看；\n2.限制在300字内；\n3.文章发布不可包含行业敏感词（例如盘口、盘路、中水、高水、降水等）；更多敏感词详见发文提示。\n4.方案审核时间：9:00~0:00。请在这段时间发文。\n5.发布方案的时间请提前比赛开始3小时。否则可能导致方案审核过期。\n6.引文不可与正文内容重复。',
                  hintStyle:
                      TextStyle(fontSize: rpx(14), color: MyColors.grey_99),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextWidget(
              '    正文(必填)',
              fontSize: rpx(14),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: rpx(240),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1,
                  color: const Color(0xFFF6F6F6),
                ),
              ),
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: rpx(10)),
              padding: const EdgeInsets.fromLTRB(10, 35, 10, 25),
              child: TextField(
                controller: descController,
                autofocus: false,
                minLines: 8,
                maxLines: 12,
                maxLength: 1000,
                onChanged: (s) {
                  setState(() {
                    desc = s;
                  });
                },
                decoration: InputDecoration(
                  labelStyle:
                      TextStyle(fontSize: rpx(14), color: MyColors.black_33),
                  hintText:
                      '1.正文内容付费前屏蔽，用户付费后才可查看。\n2.标题的场次内容必须与比赛内容一致\n3.至少达到300字，最多不超过1000字\n必须原创，不得抄袭。抄袭将被封号处理。\n5.不可出现行业敏感词（例如盘口、盘路、中水、高水、降水等）；更多敏感词详见发文提示。\n6.不能出现具有煽动性、诱导性、承诺性等类型的词汇。比如：必红、爆红、5星重心等。',
                  hintStyle:
                      TextStyle(fontSize: rpx(14), color: MyColors.grey_99),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: rpx(10),
            ),
            Container(
              margin: EdgeInsets.only(left: rpx(10)),
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
                                color:
                                    const Color.fromARGB(255, 233, 233, 233))),
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
            ),
            Container(
              margin: EdgeInsets.all(rpx(10)),
              alignment: Alignment.center,
              child: title != "" && desc.length >= 1 && checkFootList.isNotEmpty
                  ? clickBtn('发布', () {
                      List<JcFootModel> l =
                          map[widget.type]!.getValidCheckList(checkFootList);

                      if (l.isEmpty) {
                        Loading.tip("uri", "请选择玩法");
                        return;
                      }
                      Map<String, dynamic> m = {
                        "desc": desc,
                        "introduce": introduce,
                        "footmodel": l,
                        "type": widget.type,
                        "title": title,
                        "files": imgs.map((e) => e.path).toList()
                      };

                      PlanModel planModels = PlanModel.fromJson(m);
                      //  print(jsonEncode(planModels));
                      G.router.pop(context, planModels);
                    })
                  : disableBtn('发布', () {}),
            ),
          ],
        ),
      ),
    );
  }

  send() {}

  show(int id) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        builder: (BuildContext context) {
          return Container(
            color: Colors.transparent,
            padding: EdgeInsets.fromLTRB(15.w, rpx(20), 15.w, 0),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: TextWidget(
                        '选择比赛',
                        fontWeight: FontWeight.w500,
                        fontSize: rpx(15),
                      ),
                    ),
                    onClick(
                        const Icon(
                          Icons.close,
                          color: MyColors.tip,
                        ), () {
                      Routes.popPage();
                    })
                  ],
                ),
                SizedBox(
                  height: rpx(10),
                ),
                Expanded(
                    child: ListView(
                  children: getChild(id),
                )),
              ],
            ),
          );
        });
  }

  getChild(int id) {
    return List.generate(
        jcFootList.length,
        (index) => Column(
              children: [
                onClick(map[widget.type]!.PlanGameTitle(jcFootList[index]),
                    () => getJcGamePl(jcFootList[index], id)),
                SizedBox(
                  height: rpx(5),
                )
              ],
            ));
  }

  getJcGamePl(JcFootModel f, int id) async {
    if (checkFootList.where((element) => element.id == f.id).isNotEmpty) {
      Loading.tip("top", "此方案已存在");
      return;
    }
    map[widget.type]!.setGamePl(f).then((value) => setState(() {
          f.setJcFootMetModel(value);
        }));

    if (is_add == false) {
      checkFootList[id] = f;
    } else {
      checkFootList.add(f);
    }

    G.router.pop(context);
  }

  getPlanList() {
    return Column(
      children: List.generate(
          checkFootList.length,
          (index) => Column(
                children: [
                  map[widget.type]!.PlanGameDetail(checkFootList[index], index,
                      (int id) {
                    if (checkFootList.elementAtOrNull(id) != null) {
                      setState(() {
                        checkFootList.removeAt(id);
                      });
                    }
                  }, (int id) {
                    setState(() {
                      is_add = false;
                    });
                    show(id);
                  }),
                  index < checkFootList.length - 1
                      ? Container(
                          height: rpx(0.5),
                          color: const Color.fromARGB(255, 219, 219, 219),
                          width: MediaQuery.of(context).size.width,
                        )
                      : Container()
                ],
              )),
    );
  }
}
