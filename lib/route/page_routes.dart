import 'package:challange_mobile/page/assessment/assessment_page.dart';
import 'package:challange_mobile/page/detail_question/detail_question_page.dart';
import 'package:challange_mobile/page/detail_question/widgets/survei_question.dart';
import 'package:challange_mobile/page/login/login_page.dart';
import 'package:challange_mobile/route/route_name.dart';
import 'package:get/get.dart';

class PagesRoute {
  static final pages = [
    GetPage(name: RouteName.login, page: ()=> LoginPage()),
    GetPage(name: RouteName.assessment, page: ()=> AssessmentPage()),
    GetPage(name: RouteName.detailQuestion, page: ()=> DetailQuestionPage()),
  ];
}