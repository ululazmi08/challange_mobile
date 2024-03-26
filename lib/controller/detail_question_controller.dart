import 'dart:async';

import 'package:challange_mobile/model/detail_question_model.dart';
import 'package:challange_mobile/model/save_answer_model.dart';
import 'package:challange_mobile/service/detail_question_service.dart';
import 'package:challange_mobile/service/send_answer_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailQuestionController extends GetxController {
  var detailQuestion = Rxn<DetailQuestionModel>();
  var id = ''.obs;
  var loadingQuestion = false.obs;
  var currentIndex = 0.obs;
  var selectedOptionIndex = (-1).obs; // Initialize with -1
  var seconds = 30.obs;
  late Timer _timer;
  var isCheckedList = <bool>[].obs;
  var selectedAnswer = <SaveAnswer>[].obs;

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
    String selectedOptionId = detailQuestion.value!.question[currentIndex.toInt()].options[index].optionid;
    if (isCheckedList[index]) {
      // Remove ID from list if unchecked
      selectedAnswer.remove(SaveAnswer(questionId: detailQuestion.value!.question[currentIndex.toInt()].questionid, answerIds: [selectedOptionId]));
    } else {
      // Add ID to list if checked
      selectedAnswer.add(SaveAnswer(questionId: detailQuestion.value!.question[currentIndex.toInt()].questionid, answerIds: [selectedOptionId]));
    }
    isCheckedList[index] = !isCheckedList[index];
  }

  void showNextQuestion() async {
    if (currentIndex.value < detailQuestion.value!.question.length - 1) {
      print('current Index : ${currentIndex.value}\nquestion lenght : ${detailQuestion.value!.question.length}');
      if(currentIndex.value == detailQuestion.value!.question.length -1){
        print('berhasil');
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
        } else {
          Get.snackbar(data['message'], data['data']);
          selectedAnswer.clear();
        }
      }
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
    String selectedOptionId = detailQuestion.value!.question[currentIndex.toInt()].options[index].optionid;
    selectedAnswer.add(SaveAnswer(questionId: detailQuestion.value!.question[currentIndex.toInt()].questionid, answerIds: [selectedOptionId]));
  }
}