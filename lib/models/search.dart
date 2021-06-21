import 'package:flutter_ecoapp/models/base.dart';
import 'package:flutter_ecoapp/models/district.dart';

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

class SearchFilterModel{
  final String? category;
  final int? minPrice;
  final int? maxPrice;
  final DistrictModel? district;

  Map<String, dynamic> toMap() => {}..addAll(category != null? {'category': category} : {})
    ..addAll(minPrice != null? {'min_price': minPrice} : {})
    ..addAll(maxPrice != null? {'max_price': maxPrice} : {})
    ..addAll(district != null? {'district_id': district?.id} : {});

  SearchFilterModel({this.category, this.minPrice, this.maxPrice, this.district});
}