class Question {
  String num;
  String title;
  int? ans;

  Question({required this.num, required this.title, this.ans});

  @override
  String toString() {
    return 'Question{num: $num, title: $title, ans: $ans}';
  }
}
