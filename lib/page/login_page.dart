import 'package:challange_mobile/controller/login_controller.dart';
import 'package:challange_mobile/utilities/colors.dart';
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
          child:  Column(
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
                ()=> Form(
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
                        decoration: InputDecoration(
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          hintText: 'email@mail.com',
                          hintStyle: TStyle.w400
                              .copyWith(fontSize: 15, color: const Color(0xFF757575)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(color: Color(0xFFD6E4EC)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide:
                            const BorderSide(color: Color(0xFFD6E4EC), width: 1),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),

                        ),
                        validator: (value){
                          if (value == null ||
                              value.isEmpty) {
                            return "Masukkan Email";
                          }
                          return null;
                        },
                        style: TStyle.w400.copyWith(
                          fontSize: 15,
                          color: Color(0XFF757575),
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
                          obscureText: controller.eyePassword.value ? true : false,
                          decoration: InputDecoration(
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            hintText: '******',
                            hintStyle: TStyle.w400.copyWith(
                              fontSize: 15,
                              color: const Color(0xFF757575),
                            ),
                            suffixIcon: InkWell(
                              onTap: () {
                                controller.eyePassword.value =
                                !controller.eyePassword.value;
                              },
                              child: controller.eyePassword.value
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide:
                                const BorderSide(color: Color(0xFFD6E4EC))),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(
                                  color: Color(0xFFD6E4EC), width: 1),

                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Masukkan password";
                            }
                            return null;
                          },
                          style: TStyle.w400
                              .copyWith(fontSize: 15, color: Color(0XFF757575)),
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
                        .copyWith(fontSize: 15, color: Color(0xFF757575)),
                  )
                ],
              ),
              const SizedBox(height: 48),
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: Color(0xFF1FA0C9),
                  borderRadius: BorderRadius.circular(4),
                  // border: Border.all(
                  //   color: Color(0xFF1FA0C9),
                  // ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Get.dialog(Container(child: Center(child: CircularProgressIndicator(),),),barrierDismissible: false);
                      controller.login();
                    },
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Log in',
                            style: TStyle.w600
                                .copyWith(fontSize: 15, color: kColorWhite),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(child: Text('or', style: TStyle.w500.copyWith(color: kColorBlue))),
              const SizedBox(height: 16),
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: kColorWhite,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Color(0xFF1FA0C9),
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      controller.doBiometric();
                    },
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Fingerprint',
                            style: TStyle.w600
                                .copyWith(fontSize: 15, color: kColorBlue),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
