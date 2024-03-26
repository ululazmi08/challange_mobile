import 'package:challange_mobile/model/assessment_model.dart';
import 'package:challange_mobile/route/route_name.dart';
import 'package:challange_mobile/utilities/asset_constant.dart';
import 'package:challange_mobile/utilities/colors.dart';
import 'package:challange_mobile/utilities/typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AssessmentItem extends StatelessWidget {
  AssessmentItem({required this.data});

  final AssessmentModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4)
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
                    color: kColorWhiteGrey)),
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
                          color: kColorBlackMain,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Created At: ${DateFormat('dd MMM y').format(DateTime.parse(data.createdAt))}',
                        style: TStyle.w500
                            .copyWith(
                            fontSize: 12,
                            color: kColorGreen),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Last Download: ${data.downloadedAt}',
                        style: TStyle.w500
                            .copyWith(
                            fontSize: 12,
                            color: kColorGreen),
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
    );
  }
}
