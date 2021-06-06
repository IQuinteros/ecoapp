import 'package:flutter_ecoapp/models/base.dart';

class SearchModel extends BaseModel
{
  late String searchText;
  late DateTime searchDate;

  SearchModel({
    required int id,
    required this.searchText,
    required this.searchDate
  }) : super(id: id);

  SearchModel.fromJsonMap(Map<String, dynamic> json) : super(id: json['id']){
    searchText            = json['searchText'];
    searchDate            = json['searchDate'];
  }

  @override
  Map<String, dynamic> toJson() => {
    'id'          : id,
    'searchText'  : searchText,
    'searchDate'  : searchDate,
  };
}