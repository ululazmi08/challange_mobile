import 'dart:convert';

import 'package:challange_mobile/service/api_endpoint.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AssessmentService {
  static Future assessment({String? page, String? limit = '10'}) async {
    print('Assessment Service');
    print('$baseUrl/assessments?page=$page&limit=$limit');
    var response = await http.get(Uri.parse('$baseUrl/assessments?page=$page&limit=$limit'),
      headers: {
        'Accept': '*/*',
        'Content-Type' : 'application/json',
        'Cookie' : 'refresh_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlX2lkIjoiIiwicGVybWlzc2lvbnMiOm51bGwsImV4cCI6MTcwODg3MTQwMSwiaXNzIjoiU1lOMTAifQ.4DMdMtHA8_6KZSCfbsujJwLeXxCK7cKGMtMfcoEroM8; token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlX2lkIjoiNCIsInBlcm1pc3Npb25zIjpbMTMwLDEzMywxMzUsMTM4LDE0MiwxNTQsMSwyLDMsNCw1LDYsOSwxMSwxMiwxMywxNywxMF0sImV4cCI6MTcwNjM2NTgwMSwiaXNzIjoiU1lOMTAifQ.Od9oMcyO5ZMvBXfiKFH3hVBPdLqzYQQUgRinoNM_saw'
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
