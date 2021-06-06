import 'package:flutter_ecoapp/models/district.dart';
import 'package:flutter_ecoapp/providers/base_api.dart';

class DistrictAPI extends BaseAPI<DistrictModel>{
  DistrictAPI() : super(
    baseUrl: 'profile',
    getJsonParams: (item) => item.toJson(),
    constructor: (data) => DistrictModel.fromJsonMap(data)
  );
}
