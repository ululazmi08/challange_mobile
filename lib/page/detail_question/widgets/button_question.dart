import 'package:challange_mobile/utilities/colors.dart';
import 'package:challange_mobile/utilities/typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonQuestion extends StatelessWidget {
  ButtonQuestion(
      {required this.text,
        required this.onTap,
        this.borderColor = kColorBlue,
        this.containerColor = kColorBlue,
        this.textColor = kColorWhite});

  final String text;
  final VoidCallback onTap;
  final Color borderColor;
  final Color containerColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: () {
            onTap();
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TStyle.w600.copyWith(fontSize: 15, color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
