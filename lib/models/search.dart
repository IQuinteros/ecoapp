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
    searchText            = json['search_text'];
    searchDate            = DateTime.parse(json['search_date']);
  }

  @override
  Map<String, dynamic> toJson() => {
    'id'          : id,
    'search_text'  : searchText,
    'search_date'  : searchDate.toString(),
  };
}