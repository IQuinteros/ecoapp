import 'package:flutter_ecoapp/bloc/base_bloc.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/cart.dart';
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
    'profile_id': profile.id
  });


  Future<List<ArticleToPurchase>> getArticlesFromPurchase(PurchaseModel purchase) async => await articlePurchaseAPI.selectAll(
    params: {
      'purchase_id': purchase.id
    }
  );

  Future<bool> newPurchase(CartModel cart, ProfileModel profileModel) async {
    return (await purchaseAPI.insert(
      item: PurchaseModel(
        id: 0, 
        total: cart.totalPrice.toInt(), 
        createdDate: DateTime.now(), 
        info: InfoPurchaseModel(
          id: 0,
          names: profileModel.fullName,
          location: profileModel.location,
          district: profileModel.district?.name ?? 'Sin definir',
          contactNumber: profileModel.contactNumber.toString()
        ), 
        articles: cart.articles.map<ArticleToPurchase>((e) => ArticleToPurchase(
          id: 0,
          title: e.article!.title,
          quantity: e.quantity,
          unitPrice: e.article!.price,
          photoUrl: e.article!.photos.length > 0? e.article!.photos[0].photoUrl : '',
          articleId: e.article!.id,
          store: e.article!.store,
          form: e.article!.form
        )).toList()
      ),
      additionalParams: {
        'profile_id': profileModel.id
      }
    )).object != null;
  }
  
  @override
  Stream mapEventToState(event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}