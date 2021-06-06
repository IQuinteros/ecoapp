import 'package:flutter_ecoapp/models/base.dart';

class QuestionModel extends BaseModel
{
  String question;
  DateTime date;

  AnswerModel? answer;

  QuestionModel({
    required int id,
    required this.question,
    required this.date,
    this.answer
  }) : super(id: id);

  @override
  Map<String, dynamic> toJson() => {
    'id'        : id,
    'question'  : question,
    'answer'    : answer,
    'date'      : date
  };
}

class AnswerModel extends BaseModel
{
  String answer;
  DateTime date;

  AnswerModel({
    required int id,
    required this.answer,
    required this.date,
  }) : super(id: id);

  @override
  Map<String, dynamic> toJson() => {
    'id'      : id,
    'answer'  : answer,
    'date'    : date,
  };
}