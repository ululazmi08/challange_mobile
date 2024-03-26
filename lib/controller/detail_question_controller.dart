import 'dart:async';

import 'package:challange_mobile/model/detail_question_model.dart';
import 'package:challange_mobile/model/save_answer_model.dart';
import 'package:challange_mobile/service/detail_question_service.dart';
import 'package:challange_mobile/service/send_answer_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DetailQuestionController extends GetxController {
  var detailQuestion = Rxn<DetailQuestionModel>();
  var id = ''.obs;
  var loadingQuestion = false.obs;
  var currentIndex = 0.obs;
  var selectedOptionIndex = (-1).obs; // Initialize with -1
  var seconds = 120.obs;
  late Timer _timer;
  var isCheckedList = <bool>[].obs;
  var selectedAnswer = <SaveAnswer>[].obs;
  final storage = GetStorage();

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
          //lakukan sesuatu
          // submitAnswer();
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
    String selectedOptionId =
        detailQuestion.value!.question[currentIndex.toInt()].options[index].optionid;
    String questionId =
        detailQuestion.value!.question[currentIndex.toInt()].questionid;

    // Check if SaveAnswer with the same questionId already exists
    int existingIndex = selectedAnswer.indexWhere((answer) => answer.questionId == questionId);

    if (existingIndex != -1) {
      // If exists, update existing SaveAnswer with new answerIds
      if (isCheckedList[index]) {
        selectedAnswer[existingIndex].answerIds.remove(selectedOptionId);
      } else {
        selectedAnswer[existingIndex].answerIds.add(selectedOptionId);
      }
      // Remove SaveAnswer if it has no answerIds
      if (selectedAnswer[existingIndex].answerIds.isEmpty) {
        selectedAnswer.removeAt(existingIndex);
      }
    } else {
      // If doesn't exist, create new SaveAnswer
      if (!isCheckedList[index]) {
        selectedAnswer.add(SaveAnswer(questionId: questionId, answerIds: [selectedOptionId]));
      }
    }
    isCheckedList[index] = !isCheckedList[index];
  }

  void showNextQuestion() async {
    if (currentIndex.value < detailQuestion.value!.question.length - 1) {

      currentIndex.value++;
    }
  }

  void submitAnswer()async{
    Get.dialog(Container(child: Center(child: CircularProgressIndicator(),),),barrierDismissible: false);
    try{
      var data = await SendAnswerService.sendAnswer(detailQuestion.value!.id, selectedAnswer);
      if (data['status'] == true){
        selectedAnswer.clear();
        Get.dialog(
          Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(data['message']),
              ],
            ),
          ),
        );
        Get.back();
      } else {
        Get.snackbar(data['message'], data['data']);
        selectedAnswer.clear();
        Get.back();
      }
    }catch(e){
      Get.back();
      print('Error Submit : $e');
      Get.snackbar("Error", "Failed to submit answer: $e\n send data : ${storage.read('json_submit')}",backgroundColor: Colors.red.shade300);
      // Get.defaultDialog(title: "Error", middleText: "Failed to submit answer: $e\n send data : ${storage.read('json_submit')}",backgroundColor: Colors.red.shade300);
      // Get.bottomSheet(
      //   backgroundColor: Colors.red.shade300,
      //   Text("Failed to submit answer: $e\n send data : ${storage.read('json_submit')}"),
      // );
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
    String selectedOptionId = detailQuestion.value!.question[currentIndex.toInt()].options[index].optionid;
    selectedAnswer.add(SaveAnswer(questionId: detailQuestion.value!.question[currentIndex.toInt()].questionid, answerIds: [selectedOptionId]));
  }
}