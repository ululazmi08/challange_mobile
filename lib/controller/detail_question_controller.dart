import 'package:challange_mobile/model/detail_question_model.dart';
import 'package:challange_mobile/service/detail_question_service.dart';
import 'package:get/get.dart';

class DetailQuestionController extends GetxController {
  var detailQuestion = Rxn<DetailQuestionModel>();
  var id = ''.obs;
  var loadingQuestion = false.obs;
  var currentIndex = 0.obs;
  var selectedOptionIndex = (-1).obs; // Initialize with -1

  @override
  void onInit() {
    id.value = Get.arguments;
    getDetailQuestion();
    super.onInit();
  }

  void getDetailQuestion()async{
    // print('Proses Login');
    loadingQuestion.value = true;
    try{
      var data = await DetailQuestionService.detailQuestion(id.value);
      if(data['code'] == 200){
        detailQuestion.value = DetailQuestionModel.fromJson(data['data']);
        loadingQuestion.value = false;
      } else {
        loadingQuestion.value = false;
      }
    } catch (e){
      print('ERR DETAIL Quest : $e');
      loadingQuestion.value = false;

    }
  }

  void showNextQuestion() {
    if (currentIndex.value < detailQuestion.value!.question.length - 1) {
      currentIndex.value++;
    }
  }

  void showPreviousQuestion() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
    } else if(currentIndex.value == 0){
      Get.back();
    }
  }

  void updateOptionStatus(int index) {
    selectedOptionIndex.value = index;
    // Add logic here to handle the selected option as needed
  }
}