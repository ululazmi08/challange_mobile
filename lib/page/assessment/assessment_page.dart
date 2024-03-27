import 'package:challange_mobile/controller/assessment_controller.dart';
import 'package:challange_mobile/page/assessment/widget/assessment_item.dart';
import 'package:challange_mobile/utilities/colors.dart';
import 'package:challange_mobile/utilities/typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AssessmentPage extends StatelessWidget {
  AssessmentPage({Key? key}) : super(key: key);
  AssessmentController controller = Get.put(AssessmentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      body: SafeArea(
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: controller.enablePullUp.value,
          controller: controller.refreshController,
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 1000));
            controller.refreshController.refreshCompleted();
            controller.getAssessment(reset: true);
          },
          onLoading: () async {
            await Future.delayed(const Duration(milliseconds: 1000));
            controller.getAssessment();
            controller.refreshController.loadComplete();
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'Halaman Assessment',
                    style: TStyle.w500.copyWith(fontSize: 17),
                  ),
                ),
                Obx(
                  () {
                    return controller.loadingAssessment.value
                        ? Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.listAssessment.length,
                              itemBuilder: (BuildContext context, int index) {
                                var data = controller.listAssessment[index];
                                return Column(
                                  children: [
                                    AssessmentItem(data: data),
                                    const SizedBox(height: 8),
                                  ],
                                );
                              },
                            ),
                          );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
