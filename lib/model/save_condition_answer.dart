class SaveConditionAnswer {
  final String questionId;
  final List<String> answerIds;
  final int selectedOptionIndex; // Menyimpan indeks opsi yang dipilih

  SaveConditionAnswer({required this.questionId, required this.answerIds, this.selectedOptionIndex = -1}); // Default -1 jika tidak ada opsi yang dipilih

  Map<String, dynamic> toJson() {
    return {
      'question_id': questionId,
      'answer': answerIds,
      'selected_option_index': selectedOptionIndex, // Menambahkan selectedOptionIndex ke dalam JSON
    };
  }
}