class SaveAnswer {
  final String questionId;
  final dynamic answer;

  SaveAnswer({required this.questionId, required this.answer});

  Map<String, dynamic> toJson() {
    return {
      'question_id': questionId,
      'answer': answer,
    };
  }
}
