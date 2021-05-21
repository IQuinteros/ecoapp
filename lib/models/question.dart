import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/base.dart';

class QuestionModel extends BaseModel
{
  String question;
  DateTime date;

  QuestionModel({
    @required int id,
    @required this.question,
    @required this.date,
  }) : super(id: id);
}

class AnswerModel extends BaseModel
{
  String answer;
  DateTime date;

  AnswerModel({
    @required int id,
    @required this.answer,
    @required this.date,
  }) : super(id: id);
}