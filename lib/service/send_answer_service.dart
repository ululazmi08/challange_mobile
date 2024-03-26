import 'dart:convert';

import 'package:challange_mobile/model/save_answer_model.dart';
import 'package:challange_mobile/service/api_endpoint.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

final storage = GetStorage();


class SendAnswerService {
  static Future sendAnswer(String assessment_id, List<SaveAnswer> answers) async {
    print('Send Answer Serivice');
    List<Map<String, dynamic>> jsonAnswers = answers.map((answer) => answer.toJson()).toList();

    var response = await http.post(Uri.parse('$baseUrl/assessments/send-answer'),
      headers: {
        'Accept': '*/*',
        'Content-Type' : 'application/json',
        'Cookie' : '${storage.read('token')}; ${storage.read('refresh_token')}'
      },
      body: json.encode({
        "assessment_id": assessment_id,
        "answers": jsonAnswers,
      }),
    );

    print(json.encode({
      "assessment_id": assessment_id,
      "answers": jsonAnswers,
    }),);
    storage.write('json_submit', json.encode({
      "assessment_id": assessment_id,
      "answers": jsonAnswers,
    }));

    debugPrint("SEND Answer RES : " + response.body);
    // if (response.statusCode != 200) return json.decode(response.body);
    // return json.decode(response.body);
    if (response.body != null) {
      print("Response body: ${response.body}");
    } else {
      print("Empty response body");
    }
  }
}
