import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jingcai_app/enum/planCheckState.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/colors.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/loading.dart';
import 'package:jingcai_app/util/rpx.dart';

class planCheck extends StatefulWidget {
  int state;
  Function? setCheckState;
  String? refuse_text;
  planCheck({required this.state, this.setCheckState, this.refuse_text});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return planCheck_();
  }
}

class planCheck_ extends State<planCheck> {
  bool select = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getWidget();
  }

  Widget getWidget() {
    if (widget.state == planCheckState.noCheck.number) {
      return noCheck();
    }
    if (widget.state == planCheckState.planCheckSuc.number) {
      return planSuc();
    }
    if (widget.state == planCheckState.checking.number ||
        widget.state == planCheckState.memberChecking.number) {
      return checking();
    }
    if (widget.state == planCheckState.checFail.number ||
        widget.state == planCheckState.memberCheckFail.number) {
      return checkFail();
    }
    if (widget.state == planCheckState.allRight.number) {
      return checkSuccess();
    }
    return Container();
  }

  Widget noCheck() {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: rpx(100),
            ),
            shuoming()
          ],
        ),
        Positioned(
            width: MediaQuery.of(context).size.width,
            left: 0,
            bottom: 0,
            child: Container(
              color: MyColors.white,
              padding: EdgeInsets.only(bottom: rpx(20), top: rpx(20)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Radio(
                      //   value: 1,
                      //   groupValue: groupValue,
                      //   activeColor: MyColors.red,
                      //   onChanged: (index) {
                      //     groupValue = index as int;
                      //     setState(() {});
                      //   },
                      // ),
                      onClick(
                          select
                              ? Container(
                                  width: 18.w,
                                  height: 18.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.w),
                                    border: Border.all(
                                      width: 1,
                                      color: MyColors.red,
                                    ),
                                  ),
                                  child: Container(
                                    width: 14.w,
                                    height: 14.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.w),
                                      color: MyColors.red,
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 18.w,
                                  height: 18.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.w),
                                    border: Border.all(
                                      width: 1,
                                      color: MyColors.grey_99,
                                    ),
                                  ),
                                ), () {
                        setState(() {
                          select = !select;
                        });
                      }),
                      SizedBox(
                        width: 10.w,
                      ),
                      TextWidget(
                        '阅读并同意',
                        color: MyColors.grey_99,
                        fontSize: rpx(13),
                      ),
                      TextWidget(
                        '《作者规则说明》',
                        color: Colors.blue,
                        fontSize: rpx(13),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                  clickBtn('下一步', () async {
                    if (select == false) {
                      Loading.tip("uri", "请阅读并同意协议");
                      return;
                    }
                    gotoCheck();
                  }),
                ],
              ),
            ))
      ],
    );
  }

  Future<void> gotoCheck() async {
    await G.router.navigateTo(context, "/subTalentHand");
    if (mounted) {
      // final arguments =
      //     ModalRoute.of(context)?.settings.arguments as Map;
      // final result = arguments['result'];
      // print(result);
      widget.setCheckState!();
    }
  }

  Widget checkFail() {
    return Wrap(
      spacing: rpx(10),
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.vertical,
      children: [
        Image.asset(
          "assets/images/checkFail.png",
          width: rpx(180),
          fit: BoxFit.cover,
        ),
        Container(
          width: rpx(250),
          child: TextWidget(
            "很遗憾，您的签约申请不符合平台要求，已被拒绝通过。您可以在研究拒绝理由和作者规则后，重新发起签约申请~ ",
            fontSize: rpx(14),
            maxLines: 3,
            leading: 0.2,
          ),
        ),
        Wrap(
          children: [
            Container(
              width: rpx(70),
              child: TextWidget(
                "拒绝理由：",
                fontSize: rpx(14),
                color: Colors.grey,
              ),
            ),
            Container(
              width: rpx(150),
              child: TextWidget(
                widget.refuse_text.toString(),
                fontSize: rpx(14),
                maxLines: 3,
                color: Colors.red,
                textAlign: TextAlign.left,
                leading: 0.2,
              ),
            ),
          ],
        ),
        SizedBox(
          height: rpx(10),
        ),
        onClick(
            Container(
              alignment: Alignment.center,
              height: rpx(30),
              padding: EdgeInsets.symmetric(horizontal: rpx(50)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: Colors.red),
              child: TextWidget(
                "重新提交",
                fontSize: rpx(14),
                color: Colors.white,
              ),
            ), () {
          gotoCheck();
        })
      ],
    );
  }

  Widget planSuc() {
    return Wrap(
      spacing: rpx(10),
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.vertical,
      children: [
        Image.asset(
          width: rpx(180),
          "assets/images/talent_check.png",
          fit: BoxFit.cover,
        ),
        TextWidget(
          "达人方案审核已通过，请实名认证 ",
          fontSize: rpx(14),
        ),
        SizedBox(
          height: rpx(20),
        ),
        Container(
          width: rpx(200),
          child: clickBtn("实名认证", () async {
            await G.router.navigateTo(context, "/realName").then((value) {
              widget.setCheckState!();
            });
          }),
        )
      ],
    );
  }

  Widget checking() {
    return Wrap(
      spacing: rpx(10),
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.vertical,
      children: [
        Image.asset(
          width: rpx(180),
          "assets/images/talent_check.png",
          fit: BoxFit.cover,
        ),
        TextWidget(
          "您的文章、专家资料正在审核中~ ",
          fontSize: rpx(14),
        ),
        SizedBox(
          height: rpx(20),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          direction: Axis.vertical,
          children: [
            TextWidget(
              "审核过程可能持续1-5个工作日。请注意登录 ",
              fontSize: rpx(14),
              color: Colors.grey,
            ),
            TextWidget(
              "平台查看审核进度。 ",
              fontSize: rpx(14),
              color: Colors.grey,
            ),
            TextWidget(
              "如果疑问，请联系我司客服。 ",
              fontSize: rpx(14),
              color: Colors.grey,
            ),
          ],
        )
      ],
    );
  }

  Widget checkSuccess() {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: rpx(20),
      direction: Axis.vertical,
      children: [
        Icon(
          Icons.check_box,
          size: rpx(180),
          color: Colors.green,
        ),
        TextWidget(
          "审核通过",
          fontSize: rpx(26),
          color: Colors.red,
        ),
        TextWidget(
          "恭喜您成为福神体育达人!",
          fontSize: rpx(26),
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget shuoming() {
    return Expanded(
      child: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              '作者规则说明：',
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.left,
              fontSize: rpx(18),
            ),
            SizedBox(
              height: 10,
            ),
            TextWidget(
              '         福神体育致力于为内容创作者提供良好的创作环境，平台鼓励原创，鼓励提高行文质量，给读者以更高的阅读体验。同时，对文章内容进行严格的把控，严禁杜绝抄袭、敷衍推荐等行为，并持续进行严厉的打击。为规范管理福神体育，为用户打造公平、高品质的平台，特发公告如下：',
              fontSize: rpx(16),
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            SizedBox(
              height: 20,
            ),
            TextWidget(
              '一、帐号相关守则',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            SizedBox(
              height: 10,
            ),
            TextWidget(
              '1.作者需预先设置好昵称；',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            SizedBox(
              height: 10,
            ),
            TextWidget(
              '2.作者的昵称、头像和简介不得含有任何形式的广告、政治相关内容和不雅字句；',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            SizedBox(
              height: 10,
            ),
            TextWidget(
              '3.作者帐号所有权归平台所有，禁止任何赠与、借用、租用、转让或售卖帐号等行为，一经发现立即取消发文资格。',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            SizedBox(
              height: 20,
            ),
            TextWidget(
              '二、作者发文规则',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            SizedBox(
              height: 10,
            ),
            TextWidget(
              '1.作者通过平台发表的文章须为原创内容，内容应当满足与预测对应场次赛事的相关性，并保证文章内容的有效性。文章正文字数必须超过300个字及以上，包含球队胜负平概率、球队比分差距分析和主客队基本面内容，且不得使用符号、字母等任何形式搪塞字数要求；',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            SizedBox(
              height: 10,
            ),
            TextWidget(
              '2作者发表的文章中带有的图片须为原创内容，内容应当满足与预测对应场次赛事的相关性，并保证内容的有效性、真实性，发布图片不可包含二维码、群号等任何带有联系方式的图片；',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            SizedBox(
              height: 10,
            ),
            TextWidget(
              '3作者发表的文章、图片不得含有大量错别字，不得含有任何形式的广告、政治相关内容和不雅字句；',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            SizedBox(
              height: 10,
            ),
            TextWidget(
              '4.作者发表的文章、图片内容不得抄袭、不得侵犯任何第三方权益（包括但不限于知识产权、姓名权、名誉权等权益)。若作者发表的文章与网络文章有60%相似度，且发布时间迟于网络文章发布时间的，将被视为抄袭。抄袭文章若属于付费文章，相关费用应返还给付费用户，并进行封号处理，若给平台造成损失，还应赔偿损失；',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            SizedBox(
              height: 10,
            ),
            TextWidget(
              '5.每个账号只能对每场赛事进行一次预测；',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            SizedBox(
              height: 20,
            ),
            TextWidget(
              '三、发文规范',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '(一)保证内容原创性',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '1.抄袭的鉴定经用户举报抄袭的推荐文章，福神体育官方会对推荐进行再审核，抄袭的判定标准如下：',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '(1）推荐文章与他人文章内容完全重合或由多篇文章拼凑而成（包括福神体育内容及其他任意网站内容，内容包括基本面数据、分析，球队胜负平概率、球队比分差距分析等所有内容，下同)；',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '(2）推荐文章与他人文章内容部分重合或由多篇文章拼凑而成；',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '(3)推荐文章主体结构及文意同时与他人文章内容重合，无原创核心内容。',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '2.抄袭的处理',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '如用户举报抄袭经福神体育官方鉴定属实，将做出如下处理：',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '(1)付费推荐抄袭：一经发现立即取消发文资格，并进行封号处理，该篇文章付费部分将返还用户；',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '(2)免费推荐抄袭：首次发现按照抄袭给予警告并给予相应惩罚，第二次发现立即取消发文资格，并进行封号处理',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '(3)被认定文章抄袭的作者，有权在三日内联系客服进行抄袭认定申诉，超过三日将被视为放弃认定权，此后如申请抄袭认定申诉将被拒绝处理；',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '(4)进行抄袭认定的作者，如申诉成功，将取消之前的抄袭认定，如申诉失败，发现立即取消发文资格，并进行封号处理；',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '(二)保证内容质量',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '福神体育官方对无实质内容、堆积数据等内容质量差的推荐文章坚决禁止。推荐内容是福神体育的核心，也是福神体育专家与用户间的桥梁。为保证用户的阅读体验，现面向福神体育专家及用户申明福神体育官方对内容质量的规定。',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '1.内容质量差的鉴定经用户举报内容质量差的文章，福神体育官方会对推荐进行审核，内容质量差的判定标准如下：',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '(1)文章内容与推荐比赛无关（例：无意义累积字数达到最低标准，文不对题等情况)',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '(2)无原创核心内容（例：简单罗列基本面信息、文章内容不足以推导结果等情况)',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '(3)使用虚假、夸大内容（例：使用虚假、夸大、诱导性内容等情况)；',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '(4)其他可清晰认定质量差、影响阅读体验的内容。',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '2.内容质量差文章示例',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '以下为内容质量差文章示例，内容质量差的文章包括但不仅限于以下内容',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '(1)【无意义累积字数】评定标准：与赛事无关内容超过全文1/4、通过标点符号等方式凑字数的情况',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '(2)【文不对题】',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '评定标准：发送文章与所选比赛无关，通常为选错比赛的情况。',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '(3)【所选结果与文章结论相反】',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '评定标准：文章得出的结论与所选赛事结果不同，通常为文章分析胜负结果选择进球数、或者因疏忽推荐赛果选择错误的情况。',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '(4)【重复复制相同内容】',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '评定标准：专家每篇文章重复复制、粘贴相同内容超过全文1/4。',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '2.2无原创核心内容',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '(1)【简单罗列基本面信息】',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '评定标准：罗列数据超过文章内容1/2，包括主客队X胜X平X负、主客队进失球数、主客队近X场胜负、主客队近期交锋记录、比赛球队胜负平概率及其他任何数据。',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '(2)【文章内容不足以推导出推荐结果】',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '评定标准：文章论据不足，无法推导出推荐结果的情况。',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '2.3使用虚假、夸大内容',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '(1)【使用虚假编造内容作为推荐依据】',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '评定标准：推荐文章中的内容存在不实或为了推导推荐结果杜撰信息。',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '(2)【虚假编造战绩统计】',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '评定标准：专家战绩统计以福神体育官方统计为准，专家文章中不可出现虚假统计、自我统计或不易查询的统计数据。',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '(3)【出现夸大、诱导性文字】',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '判定标准：标题、或文章中出现诱导性文字内容。如专家A目前5连红，当日连续发文2篇，发文使用“冲击7连红“等；在标题及文章中使用“重锤单“、“此单必杀”、“本场必中"、“信心单”、“XX%信心"等文字，或在总结过去推荐中使用“重锤连红”、“稳胆全中"等。福神体育专家推荐文章时，每篇文章都应具备相同的认真态度，不可出现某一场比赛特别研究、特别看好等诱导性标题。',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '2.4其他可清晰认定质量差、影响阅读体验的内容',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '(1)【文章中无清晰表述对阵双方】',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '评定标准：全文没有出现对阵双方球队名称，以主队、客队或其他方式代称的情况。',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '(2)【大量错别字、标点符号及排版混乱的情况】评定标准：错别字大于5个或关键错别字影响阅读体验；标点符号使用混乱；长篇文章不分段落、排版混乱等。',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '(3)【使用非中文语言发文】',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '评定标准：标题、文章中全部或部分使用外文语言，如全篇英文、标题英文、球队名使用英文的情况。',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '(4)【付费文章，免费的内容被全部或部分复制到付费内容中】',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '(5)【标题过于随意、凑字数等情况】',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '(6)【其他影响用户阅读体验的文章内容】',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '3.内容质量差的处理',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '用户举报文章内容质量差经福神体育官方鉴定属实，将做出如下处理：',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '(1)进行相应处理，如涉及付费阅读，该篇文章付费部分将返还用户；',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            TextWidget(
              '(2)大量出现内容质量差文章的专家，将做出注销福神体育账号处理；',
              fontSize: 16,
              textAlign: TextAlign.left,
              maxLines: 10,
            ),
            SizedBox(
              height: 150,
            )
          ],
        ),
      )),
    );
  }
}
