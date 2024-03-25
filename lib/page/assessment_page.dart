import 'package:challange_mobile/controller/assessment_controller.dart';
import 'package:challange_mobile/page/detail_question/detail_question_page.dart';
import 'package:challange_mobile/route/route_name.dart';
import 'package:challange_mobile/utilities/asset_constant.dart';
import 'package:challange_mobile/utilities/colors.dart';
import 'package:challange_mobile/utilities/typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
                                    Container(
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        // border: Border.all(
                                        //   color: Color(0xFF1FA0C9),
                                        // ),
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            Get.toNamed(
                                                RouteName.detailQuestion,
                                                arguments: data.id);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                border: Border.all(
                                                    color: Color(0xFFD9D9D9))),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                data.image.isEmpty
                                                    ? Image.asset(AssetConstant.imgExam, width: 54,)
                                                    : Container(
                                                        height: 54,
                                                        width: 54,
                                                        decoration:
                                                            BoxDecoration(
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  data.image),
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                      ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        data.name,
                                                        style: TStyle.w500
                                                            .copyWith(
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xFF000000),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                        'Created At: ${DateFormat('dd MMM y').format(DateTime.parse(data.createdAt))}',
                                                        style: TStyle.w500
                                                            .copyWith(
                                                                fontSize: 12,
                                                                color: Color(
                                                                    0xFF107C41)),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                        'Last Download: ${data.downloadedAt}',
                                                        style: TStyle.w500
                                                            .copyWith(
                                                                fontSize: 12,
                                                                color: Color(
                                                                    0xFF107C41)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Image.asset(AssetConstant.icDownload, width: 24,)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
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
