import 'dart:convert';

import 'package:challange_mobile/service/api_endpoint.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

final storage = GetStorage();

class AssessmentService {
  static Future assessment({String? page, String? limit = '10'}) async {
    print('Assessment Service');
    print('$baseUrl/assessments?page=$page&limit=$limit');
    var response = await http.get(Uri.parse('$baseUrl/assessments?page=$page&limit=$limit'),
      headers: {
        'Accept': '*/*',
        'Content-Type' : 'application/json',
        'Cookie' : '${storage.read('token')}; ${storage.read('refresh_token')}'
      },
      // body: {
      //   "nik": nik,
      //   "password": password,
      // },
    );

    debugPrint("ASSESSMENT RES : " + response.body);
    if (response.statusCode != 200) return json.decode(response.body);
    return json.decode(response.body);
  }
}
