import 'package:flutter_ecoapp/models/question.dart';
import 'package:flutter_ecoapp/providers/base_api.dart';

class QuestionAPI extends BaseAPI<QuestionModel>{
  QuestionAPI({Function(FailConnectReason)? onFailConnect}) : super(
    baseUrl: 'question',
    getJsonParams: (item) => item.toJson(),
    constructor: (data) => QuestionModel.fromJsonMap(data),
    onFailConnect: onFailConnect
  );
}
