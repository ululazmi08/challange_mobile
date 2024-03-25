import 'package:challange_mobile/controller/detail_question_controller.dart';
import 'package:challange_mobile/page/detail_question/widgets/array_question.dart';
import 'package:challange_mobile/route/route_name.dart';
import 'package:challange_mobile/utilities/colors.dart';
import 'package:challange_mobile/utilities/typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailQuestionPage extends StatelessWidget {
  DetailQuestionPage({Key? key}) : super(key: key);
  DetailQuestionController controller = Get.put(DetailQuestionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Obx(
                () {
                  int minutes = controller.seconds.value ~/ 60;
                  int seconds = controller.seconds.value % 60;
                  String timeLeft = '$minutes:${seconds.toString().padLeft(2, '0')} Time Left';
                  return Container(
                    color: kColorWhite,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 9),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        color: Color(0xFF1FA0C9))),
                                child: Row(
                                  children: [
                                    Text(
                                      timeLeft,
                                      style: TStyle.w500
                                          .copyWith(color: Color(0xFF1FA0C9),
                                          fontSize: 15),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: kColorBlack,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(4),
                                  child: InkWell(
                                    onTap: () {
                                      Get.toNamed(RouteName.surveiQuestion);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.list_alt,
                                            color: kColorWhite,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            '${controller.currentIndex.value +
                                                1}/${controller.detailQuestion
                                                .value?.question.length ?? 0}',
                                            style: TStyle.w500.copyWith(
                                                fontSize: 15,
                                                color: kColorWhite),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Text(controller.detailQuestion.value?.name ?? ''),
                        ArrayQuestion()
                      ],
                    ),
                  );

                }
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        color: kColorWhite,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Color(0xFF1FA0C9))),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                  child: InkWell(
                    onTap: () {
                      controller.showPreviousQuestion();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Back',
                        textAlign: TextAlign.center,
                        style: TStyle.w600
                            .copyWith(fontSize: 15, color: kColorBlue),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: kColorBlue,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                  child: InkWell(
                    onTap: () {
                      controller.showNextQuestion();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Next',
                        textAlign: TextAlign.center,
                        style: TStyle.w600
                            .copyWith(fontSize: 15, color: kColorWhite),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
