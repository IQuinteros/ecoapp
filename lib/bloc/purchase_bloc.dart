import 'package:flutter_ecoapp/bloc/base_bloc.dart';
import 'package:flutter_ecoapp/models/profile.dart';
import 'package:flutter_ecoapp/models/purchase.dart';
import 'package:flutter_ecoapp/providers/purchase_api.dart';

class PurchaseBloc extends BaseBloc<PurchaseModel>{

  final PurchaseAPI purchaseAPI = PurchaseAPI();
  final articlePurchaseAPI = ArticlePurchaseAPI();

  @override
  Future<void> initializeBloc() async {
    return;
  }

  Future<List<PurchaseModel>> getPurchases(ProfileModel profile) async => await purchaseAPI.selectAll(params: {
    'profile': profile.id
  });


  Future<List<ArticleToPurchase>> getArticlesFromPurchase(PurchaseModel purchase) async => await articlePurchaseAPI.selectAll(
    params: {
      'purchase': purchase.id
    }
  );
  
  @override
  Stream mapEventToState(event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}