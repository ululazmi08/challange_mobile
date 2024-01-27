import 'package:challange_mobile/model/assessment_model.dart';
import 'package:challange_mobile/service/assessment_service.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AssessmentController extends GetxController {
  var listAssessment = <AssessmentModel>[].obs;
  var loadingAssessment = true.obs;
  var formattedDate = ''.obs;
  var page = 1.obs;
  var enablePullUp = true.obs;
  RefreshController refreshController = RefreshController(initialRefresh: false);


  @override
  void onInit() {
    // TODO: implement onInit
    getAssessment(reset: true);
    super.onInit();
  }

  void getAssessment({bool reset = false})async{
    if(reset){
      page.value = 1;
      listAssessment.clear();
      enablePullUp.value = true;
    }
    if(page.value == 1){
      loadingAssessment.value = true;
    }
    try{
      var data = await AssessmentService.assessment(page: page.toString());
      if(data['code'] == 200){
        page.value += 1;
        var dataList = data['data'] as List;
        List<AssessmentModel> list = dataList.map((e) => AssessmentModel.fromJson(e)).toList();
        if(list.isEmpty){
          enablePullUp.value = false;
        }
        listAssessment.addAll(list);
        loadingAssessment.value = false;
      } else {
        // Get.back();
        // Get.dialog(Dialog(child: Column(
        //   children: [
        //     Text(data['message']),
        //   ],
        // ),));
        loadingAssessment.value = false;
      }
    } catch (e){
      print('ERR Assessment : $e');
      loadingAssessment.value = false;

    }
  }
}