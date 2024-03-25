import 'dart:convert';

import 'package:challange_mobile/service/api_endpoint.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

final storage = GetStorage();

class LoginService {
  static Future login(String nik, String password) async {
    print('Login Serivice');
    var response = await http.post(Uri.parse('$baseUrl/login'),
      // headers: {
      //   'Accept': '*/*',
      //   'Content-Type' : 'application/json',
      // },
      body: {
        "nik": nik,
        "password": password,
      },
    );

    debugPrint("LOGIN RES : " + response.body);

    var token = response.headers['set-cookie'] ?? '';
    print('hasil TOKEN : $token');
    List<String> saveToken = token.split(';');
    var dataToken = saveToken[0].trim();
    storage.write('token', dataToken);
    var refreshToken = saveToken[4].trim();
    List<String> dataRefreshToken = refreshToken.split(',');
    var saveRefreshToken = dataRefreshToken[1].trim();
    storage.write('refresh_token', saveRefreshToken);
    print('Hasil real TOKEN : $dataToken; $saveRefreshToken');

    if (response.statusCode != 200) return json.decode(response.body);
    return json.decode(response.body);
  }
}
