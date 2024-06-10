enum ExampleType {
  pass,
  fail,
  na,
}

enum PassCriteria { pass, fail, passYesAll, failNoNone }

enum FollowUpCriteria { yes, no, mixed }

class SubQuestion {
  String question;
  bool? answer;
  ExampleType exampleType;

  SubQuestion({
    required this.question,
    this.answer,
    this.exampleType = ExampleType.na,
  });
}

class PhaseTwoQuestion {
  String baseString;
  String preText;
  List<SubQuestion> subQuestions;
  PassCriteria passCriteria;
  String? followUp;
  FollowUpCriteria? followUpCriteria;
  List<SubQuestion>? followUpQuestions;

  PhaseTwoQuestion({
    required this.baseString,
    required this.preText,
    required this.subQuestions,
    required this.passCriteria,
    this.followUp,
    this.followUpCriteria,
    this.followUpQuestions,
  });
}
