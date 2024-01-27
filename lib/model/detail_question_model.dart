class DetailQuestionModel {
  DetailQuestionModel({
    required this.id,
    required this.name,
    required this.question,
  });
  late final String id;
  late final String name;
  late final List<Question> question;

  DetailQuestionModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    question = List.from(json['question']).map((e)=>Question.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['question'] = question.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Question {
  Question({
    required this.questionid,
    required this.section,
    required this.number,
    required this.type,
    required this.questionName,
    required this.scoring,
    required this.options,
  });
  late final String questionid;
  late final String section;
  late final String number;
  late final String type;
  late final String questionName;
  late final bool scoring;
  late final List<Options> options;

  Question.fromJson(Map<String, dynamic> json){
    questionid = json['questionid'];
    section = json['section'];
    number = json['number'];
    type = json['type'];
    questionName = json['question_name'];
    scoring = json['scoring'];
    options = List.from(json['options']).map((e)=>Options.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['questionid'] = questionid;
    _data['section'] = section;
    _data['number'] = number;
    _data['type'] = type;
    _data['question_name'] = questionName;
    _data['scoring'] = scoring;
    _data['options'] = options.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Options {
  Options({
    required this.optionid,
    required this.optionName,
    required this.points,
    required this.flag,
  });
  late final String optionid;
  late final String optionName;
  late final int points;
  late final int flag;

  Options.fromJson(Map<String, dynamic> json){
    optionid = json['optionid'];
    optionName = json['option_name'];
    points = json['points'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['optionid'] = optionid;
    _data['option_name'] = optionName;
    _data['points'] = points;
    _data['flag'] = flag;
    return _data;
  }
}