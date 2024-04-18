import 'package:fluro/fluro.dart';
import 'package:jingcai_app/pages/home_pages/talentSearch.dart';
import './RoutesHandler.dart';

class Routes {
  static void configureRoutes(FluroRouter router) {
    router.define('/footScreen', handler: footScreenHand);
    router.define('/basketScreen', handler: basketScreenHand);
    router.define('/expertTalent', handler: expertTalentHand);
    router.define('/talentRank', handler: talentRankHand);
    router.define('/competitionList', handler: competitionListHand);
    router.define('/basketSubject', handler: basketSubjectHand);
    router.define('/expertDetail', handler: expertDetailHand);
    router.define('/gameDetail',
        handler: gameDetailHand, transitionType: TransitionType.inFromRight);
    router.define('/publish', handler: publishHand);
    router.define('/applyTalent', handler: applyTalentHand);
    router.define('/subTalentHand',
        handler: subTalentHand, transitionType: TransitionType.inFromRight);
    router.define('/dataReport',
        handler: dataReportHand, transitionType: TransitionType.inFromRight);
    router.define('/gameBigData',
        handler: gameBigDatatHand, transitionType: TransitionType.inFromRight);
    router.define('/indexChange',
        handler: indexChangeHand, transitionType: TransitionType.inFromRight);
    router.define('/indexChangeDetail',
        handler: indexChangeDetailHand,
        transitionType: TransitionType.inFromRight);
    router.define('/bsfb',
        handler: bsfbHand, transitionType: TransitionType.inFromRight);
    router.define('/bsDetail',
        handler: boSongDetailHand, transitionType: TransitionType.inFromRight);
    router.define('/indexDiff',
        handler: indexDiffHand, transitionType: TransitionType.inFromRight);
    router.define('/indexDiffDetail',
        handler: indexDiffDetailHand,
        transitionType: TransitionType.inFromRight);
    router.define('/companyDiff',
        handler: companyDiffHand, transitionType: TransitionType.inFromRight);
    router.define('/companyDiffDetail',
        handler: companyDiffDetailHand,
        transitionType: TransitionType.inFromRight);
    router.define('/leagueDetail',
        handler: leagueDetailHand, transitionType: TransitionType.inFromRight);
    router.define('/teamDetail',
        handler: teamDetailHand, transitionType: TransitionType.inFromRight);
    router.define('/basketGameDetail',
        handler: basketGameDetailHand,
        transitionType: TransitionType.inFromRight);
    router.define('/gameSearch',
        handler: gameSearchHand, transitionType: TransitionType.inFromRight);
    router.define('/hotMatch',
        handler: hotMatchhHand, transitionType: TransitionType.inFromRight);
    router.define('/publishPlan',
        handler: publishPlanHand, transitionType: TransitionType.inFromRight);
    router.define('/talentSearch',
        handler: talentSearchHand, transitionType: TransitionType.inFromRight);
    router.define('/talentDetail',
        handler: talentDetailHand, transitionType: TransitionType.inFromRight);
    router.define('/login',
        handler: loginHand, transitionType: TransitionType.inFromRight);
    router.define('/withdraw',
        handler: withdrawHand, transitionType: TransitionType.inFromRight);
  }
}
