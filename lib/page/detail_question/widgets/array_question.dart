import 'package:challange_mobile/controller/detail_question_controller.dart';
import 'package:challange_mobile/utilities/colors.dart';
import 'package:challange_mobile/utilities/typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArrayQuestion extends StatelessWidget {
  ArrayQuestion({Key? key}) : super(key: key);
  DetailQuestionController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kColorWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => controller.loadingQuestion.value
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${controller.detailQuestion.value?.question[controller.currentIndex.value].section}',
                          style: TStyle.w700.copyWith(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '${controller.detailQuestion.value?.question[controller.currentIndex.value].number}. ${controller.detailQuestion.value?.question[controller.currentIndex.value].questionName}',
                          style: TStyle.w400.copyWith(
                            fontSize: 16,
                            color: kColorGreyMain,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          Container(height: 12, color: kColorBlueSecond),
          Container(
            color: kColorWhite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 12),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Text(
                    'Answer',
                    style:
                        TStyle.w400.copyWith(fontSize: 15, color: kColorBlack),
                  ),
                ),
                Divider(
                  color: kColorWhiteGreySecond,
                  height: 0,
                  thickness: 1,
                ),
                Obx(
                  () => controller.loadingQuestion.value
                      ? Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller
                              .detailQuestion
                              .value
                              ?.question[controller.currentIndex.toInt()]
                              .options
                              .length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            var data = controller
                                .detailQuestion
                                .value
                                ?.question[controller.currentIndex.toInt()]
                                .options[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 12),
                                  Obx(
                                    () {
                                      if (controller
                                              .detailQuestion
                                              .value!
                                              .question[controller.currentIndex
                                                  .toInt()]
                                              .type ==
                                          'multiple_choice') {
                                        return Row(
                                          children: [
                                            Obx(() {
                                              return Radio(
                                                value: index,
                                                groupValue: controller
                                                    .selectedOptionIndex.value,
                                                onChanged: (value) {
                                                  // Update selected option index
                                                  controller.updateOptionStatus(
                                                      value ?? 0);
                                                },
                                              );
                                            }),
                                            Flexible(
                                              child: Text(
                                                data?.optionName ?? '',
                                                style: TStyle.w400
                                                    .copyWith(fontSize: 15),
                                              ),
                                            )
                                          ],
                                        );
                                      }
                                      if (controller
                                              .detailQuestion
                                              .value!
                                              .question[controller.currentIndex
                                                  .toInt()]
                                              .type ==
                                          'checkbox') {
                                        return CheckboxListTile(
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          title: Text(
                                            data?.optionName ?? '',
                                          ),
                                          contentPadding: EdgeInsets.zero,
                                          value:
                                              controller.isCheckedList[index],
                                          onChanged: (value) {
                                            controller.toggleCheckbox(index);
                                          },
                                        );
                                      }
                                      return SizedBox();
                                    },
                                  ),

                                  // Untuk multiple choice
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
