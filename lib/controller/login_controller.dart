import 'package:challange_mobile/route/route_name.dart';
import 'package:challange_mobile/service/login_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class LoginController extends GetxController {
  var isChecked = false.obs;
  var eyePassword = true.obs;
  var nik = TextEditingController().obs;
  var password = TextEditingController().obs;
  final GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();
  final box = GetStorage();
  final LocalAuthentication auth = LocalAuthentication();


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
    if(isChecked.value == true){
      box.write('nik', nik.value.text);
      box.write('password', password.value.text);
    } else if (isChecked.value == false) {
      box.write('nik', '');
      box.write('password', '');
    }
  }

  void login()async{
    print('Proses Login');
    if(formKeyLogin.currentState!.validate()){
      Get.dialog(Container(child: Center(child: CircularProgressIndicator(),),),barrierDismissible: false);
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

  void loginBiometrics(String nik, String password)async{
    print('Proses Login Biometrics');
    Get.dialog(Container(child: Center(child: CircularProgressIndicator(),),),barrierDismissible: false);
    try{
      var data = await LoginService.login(nik, password);
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
  }

  Future<bool> checkBiometric()async=>
    await auth.isDeviceSupported() || await auth.canCheckBiometrics;

  void doBiometric() async{
    if(await checkBiometric() == true) {
      final nik = box.read('nik');
      final password = box.read('password');
      if(isChecked.value == true && nik.toString().isNotEmpty && password.toString().isNotEmpty){
        try{
            startBiometrics(nik, password);
            print('Success doBiometric');
        } catch (e) {
          print('Error doBiometric : $e');
        }
      } else {
        Get.dialog(
          AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('You need to fill email & password and Check Remember Me'),
              ],
            ),
          ),
        );
      }
    } else {
      Get.dialog(
        AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Device not Supoorted'),
            ],
          ),
        ),
      );
    }
  }

  startBiometrics(String nik, String password) async {
    try {
      final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Silahkan Lakukan Autentikasi',
          options: const AuthenticationOptions(useErrorDialogs: false));
      if (didAuthenticate == true) {
        print("biometrik berhasil");
        loginBiometrics(nik, password);
      }

    } on PlatformException catch (e) {
      if (e.code == auth_error.notEnrolled) {
        // Add handling of no hardware here.
      } else if (e.code == auth_error.lockedOut ||
          e.code == auth_error.permanentlyLockedOut) {

      } else {

      }
    }
  }
}