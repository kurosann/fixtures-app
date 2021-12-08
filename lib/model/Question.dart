class Question {
  String num;
  String title;
  int ans;

  Question({this.num, this.title, this.ans}) : super();

  @override
  String toString() {
    return 'Question{num: $num, title: $title, ans: $ans}';
  }
}
