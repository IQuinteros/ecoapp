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

  // Get district by id
  Future<DistrictModel?> getDistrictById(int id) async
  {
    final districts = await districtAPI.selectAll(
      params: {'id': id}
    );

    if(districts.length > 0) return districts[0];
    
    return null;
  }

  @override
  Stream mapEventToState(event) {
    // TODO: implement mapEventToState
    print('MAPPING BLOC');
    throw UnimplementedError();
  }

  
}