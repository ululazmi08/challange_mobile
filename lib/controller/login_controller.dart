import 'package:challange_mobile/route/route_name.dart';
import 'package:challange_mobile/service/login_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';

class LoginController extends GetxController {
  var isChecked = false.obs;
  var eyePassword = true.obs;
  var nik = TextEditingController().obs;
  var password = TextEditingController().obs;
  final GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();
  final box = GetStorage();

  @override
  void onInit() {
    // TODO: implement onInit
    isChecked.value = box.read('isChecked') ?? false;
    nik.value.text = box.read('nik') ?? '';
    password.value.text = box.read('password') ?? '';
    super.onInit();
  }

  void rememberMe() {
    isChecked.value = !isChecked.value;
    box.write('isChecked', isChecked.value);
    if(isChecked == true){
      box.write('nik', nik.value.text);
      box.write('password', password.value.text);
    } else if (isChecked == false) {
      box.write('nik', '');
      box.write('password', '');
    }
  }

  void login()async{
    print('Proses Login');
    if(formKeyLogin.currentState!.validate()){
      try{
        var data = await LoginService.login(nik.value.text, password.value.text);
        if(data['status'] == true){
          Get.back();
          print(data['message']);
          Get.offAllNamed(RouteName.assessment);
        } else {
          Get.back();
          Get.dialog(Dialog(child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(data['message']),
            ],
          ),));
        }
      } catch (e){
        print('ERR login : $e');
        Get.back();
      }
    } else {
      Get.back();
    }
  }

  void loginBiometric() async {
    print('Proses Login');

    // Gunakan local_auth untuk otentikasi fingerprint
    bool isBiometricAvailable = await _checkBiometric();

    if (isBiometricAvailable) {
      bool isAuthenticated = await _authenticateWithBiometrics();
      if (isAuthenticated) {
        // Jika otentikasi berhasil, jalankan proses login
        login();
      } else {
        print('Otentikasi fingerprint gagal');
      }
    } else {
      // Jika perangkat tidak mendukung otentikasi fingerprint, lanjutkan ke proses login biasa
      login();
    }
  }

  Future<bool> _checkBiometric() async {
    LocalAuthentication localAuth = LocalAuthentication();
    return await localAuth.isDeviceSupported();
  }

  Future<bool> _authenticateWithBiometrics() async {
    LocalAuthentication localAuth = LocalAuthentication();
    return await localAuth.authenticate(
      localizedReason: 'Gunakan fingerprint untuk masuk',
      // useErrorDialogs: true,
      // stickyAuth: true,
    );
  }
}