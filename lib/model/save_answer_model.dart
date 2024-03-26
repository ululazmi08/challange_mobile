class SaveAnswer {
  final String questionId;
  final List<String> answerIds;

  SaveAnswer({required this.questionId, required this.answerIds});

  Map<String, dynamic> toJson() {
    return {
      'question_id': questionId,
      'answer': answerIds.join(','),
    };
  }
}
