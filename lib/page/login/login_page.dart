import 'package:challange_mobile/controller/login_controller.dart';
import 'package:challange_mobile/page/login/widget/button_login.dart';
import 'package:challange_mobile/utilities/colors.dart';
import 'package:challange_mobile/utilities/component.dart';
import 'package:challange_mobile/utilities/typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 24),
              Text(
                'Login to Synapsis',
                style: TStyle.title,
              ),
              const SizedBox(height: 34),
              Obx(
                () => Form(
                  key: controller.formKeyLogin,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 13,
                          color: kColorGrey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextFormField(
                        controller: controller.nik.value,
                        decoration: kDecorationForm.copyWith(
                          hintText: 'email@mail.com',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Masukkan Email";
                          }
                          return null;
                        },
                        style: TStyle.w400.copyWith(
                          fontSize: 15,
                          color: kColorGreyMore,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 13,
                          color: kColorGrey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextFormField(
                        controller: controller.password.value,
                        obscureText:
                            controller.eyePassword.value ? true : false,
                        decoration: kDecorationForm.copyWith(
                          hintText: '******',
                          suffixIcon: InkWell(
                            onTap: () {
                              controller.eyePassword.value =
                                  !controller.eyePassword.value;
                            },
                            child: controller.eyePassword.value
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Masukkan password";
                          }
                          return null;
                        },
                        style: TStyle.w400
                            .copyWith(fontSize: 15, color: kColorGreyMore),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      value: controller.isChecked.value,
                      onChanged: (value) {
                        controller.rememberMe();
                        // print(controller.isChecked.value);
                      },
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Remember me',
                    style: TStyle.w400
                        .copyWith(fontSize: 15, color: kColorGreyMore),
                  )
                ],
              ),
              const SizedBox(height: 48),
              // ButtonLogin(
              //     text: 'Log in',
              //     onTap: () {
              //     }),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: (){
                        controller.login();
                      },
                      color: kColorBlue,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Text('Log in', style:TStyle.w600.copyWith(fontSize: 15, color:kColorWhite),),),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'or',
                  style: TStyle.w500.copyWith(color: kColorBlue),
                ),
              ),
              const SizedBox(height: 16),
              // ButtonLogin(
              //     text: 'Fingerprint',
              //     onTap: () {
              //       controller.doBiometric();
              //     },
              //     containerColor: kColorWhite,
              //     textColor: kColorBlue,
              // ),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: (){
                        controller.doBiometric();
                      },
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        side: BorderSide(color: kColorBlue)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Text('Fingerprint', style:TStyle.w600.copyWith(fontSize: 15, color:kColorBlue),),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
