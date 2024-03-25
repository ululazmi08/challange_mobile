import 'dart:async';

import 'package:challange_mobile/model/detail_question_model.dart';
import 'package:challange_mobile/model/save_answer_model.dart';
import 'package:challange_mobile/route/route_name.dart';
import 'package:challange_mobile/service/detail_question_service.dart';
import 'package:get/get.dart';

class DetailQuestionController extends GetxController {
  var detailQuestion = Rxn<DetailQuestionModel>();
  var id = ''.obs;
  var loadingQuestion = false.obs;
  var currentIndex = 0.obs;
  var selectedOptionIndex = (-1).obs; // Initialize with -1
  var seconds = 5.obs;
  late Timer _timer;
  var isCheckedList = <bool>[].obs;

  List<SaveAnswer> answers = [];

  @override
  void onInit() {
    id.value = Get.arguments;
    getDetailQuestion();
    startTimer();
    super.onInit();
    isCheckedList.assignAll(List<bool>.filled(10, false));
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (seconds.value == 0) {
          timer.cancel();
          // Get.offAllNamed(RouteName.assessment);
          // Lakukan sesuatu saat timer selesai, misalnya tampilkan pesan atau jalankan fungsi tertentu.
        } else {
          seconds.value--;
        }
      },
    );
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
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
  void toggleCheckbox(int index) {
    isCheckedList[index] = !isCheckedList[index];
  }

  void addAnswer(String questionId, dynamic answer) {
    answers.add(SaveAnswer(questionId: questionId, answer: answer));
  }

  List<Map<String, dynamic>> get answersJson {
    return answers.map((answer) => answer.toJson()).toList();
  }

  void showNextQuestion() {
    if (currentIndex.value < detailQuestion.value!.question.length - 1) {
      // if(detailQuestion.value!.question[currentIndex.value].){
      //
      // }
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