import 'dart:async';

import 'package:flutter_ecoapp/bloc/base_bloc.dart';
import 'package:flutter_ecoapp/models/district.dart';
import 'package:flutter_ecoapp/providers/district_api.dart';

class DistrictBloc extends BaseBloc<DistrictModel>{

  final DistrictAPI districtAPI = DistrictAPI();

  DistrictBloc() : super(0){
  }

  /// Get districts
  Future<List<DistrictModel>> getDistricts() async {
    return await districtAPI.selectAll();
  }

  @override
  Stream mapEventToState(event) {
    // TODO: implement mapEventToState
    print('MAPPING BLOC');
    throw UnimplementedError();
  }

  
}