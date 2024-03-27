import 'package:challange_mobile/controller/detail_question_controller.dart';
import 'package:challange_mobile/utilities/colors.dart';
import 'package:challange_mobile/utilities/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class SurveiQuestion extends StatelessWidget {
  SurveiQuestion({Key? key}) : super(key: key);
  DetailQuestionController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kColorWhite,
      alignment: Alignment.topCenter,
      insetPadding: EdgeInsets.zero,
      child: Container(
        color: kColorWhite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Text(
                'Survei Question',
                style: TStyle.w500.copyWith(fontSize: 18.4),
              ),
            ),
            const Divider(color: kColorWhiteGrey, height: 0),
            Obx(
              () => controller.loadingQuestion.value
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : MasonryGridView.count(
                      crossAxisCount: 5,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      itemCount:
                          controller.detailQuestion.value?.question.length,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            color: controller.currentIndex.value == index
                                ? kColorBlue.withOpacity(0.2)
                                : (controller.selectedOptionIndex.value != -1) ? kColorBlue : kColorWhite,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: controller.currentIndex.value == index
                                  ? kColorBlue
                                  : controller.selectedOptionIndex.value != -1 ? kColorBlue : kColorGreySecond,
                            ),
                          ),
                          child: Text(
                            '${index + 1}',
                            textAlign: TextAlign.center,
                            style: TStyle.w500.copyWith(
                              fontSize: 18.4,
                              color: controller.currentIndex.value == index
                                  ? kColorBlue
                                  : controller.selectedOptionIndex.value != -1 ? kColorWhite : kColorGreySecond,
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
