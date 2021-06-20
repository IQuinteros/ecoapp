
import 'dart:async';

import 'package:flutter_ecoapp/providers/base_api.dart';
import 'package:flutter_ecoapp/models/profile.dart';

class ProfileAPI extends BaseAPI<ProfileModel>{
  ProfileAPI({Function(FailConnectReason)? onFailConnect}) : super(
    baseUrl: 'profile',
    getJsonParams: (item) => item.toJson(),
    constructor: (data) => ProfileModel.fromJsonMap(data),
    onFailConnect: onFailConnect
  );

  
  @override
  Future<InsertResult<ProfileModel>> insert({required ProfileModel item, String? customName, Map<String, dynamic> additionalParams = const {}}) async {
    final result = await super.insert(
      item: item, 
      customName: customName, 
      additionalParams: additionalParams, 
    );

    if(result.object != null){
      if(result.hasData){
        try{
          if(result.additionalData[1] is int)
            result.object!.userId = result.additionalData[1];
          else
            result.object!.userId = int.tryParse(result.additionalData[1]) ?? result.additionalData[1];
          
        }
        catch(e, stacktrace) {
          print(e);
          print(stacktrace);
        }
      }
    }
    return result;
  }
}
