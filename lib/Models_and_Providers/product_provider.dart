import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:read_share_disertatie_web/Models_and_Providers/products_model.dart';

class ProductsProvider with ChangeNotifier {
  static final List<ProductModel> _productsList = [];
  List<ProductModel> get getProducts {
    return _productsList;
  }

  List<ProductModel> get getHotOnSocialMediaProduct {
    return _productsList.where((element) => element.isOnFire).toList();
  }

  Future<void> fetchProducts() async {
    try {
      final productSnapshot =
          await FirebaseFirestore.instance.collection('products').get();
      print("Documents fetched: ${productSnapshot.docs.length}");

      _productsList.clear(); // VERY IMPORTANT to avoid duplicates on hot reload

      productSnapshot.docs.forEach((element) {
        print("Product fetched: ${element.data()}");
        _productsList.insert(
          0,
          ProductModel(
            id: element.get('id'),
            title: element.get('title'),
            author: element.get('author'),
            imageUrl: element.get('imageUrl'),
            productCategoryName: element.get('productCategoryName'),
            price: double.parse(element.get('price')),
            isOnFire: element.get('isHot'),
            description: element.get('description'),
          ),
        );
      });
      notifyListeners();
    } catch (error) {
      print("Error fetching products: $error");
    }
  }

  ProductModel findProductById(String productID) {
    return _productsList.firstWhere((element) => element.id == productID);
  }

  List<ProductModel> findByCategory(String categoryName) {
    List<ProductModel> _categoryList =
        _productsList
            .where(
              (element) => element.productCategoryName.toLowerCase().contains(
                categoryName.toLowerCase(),
              ),
            )
            .toList();
    return _categoryList;
  }

  List<ProductModel> searchQuerry(String searchText) {
    List<ProductModel> _searchList =
        _productsList
            .where(
              (element) => element.title.toLowerCase().contains(
                searchText.toLowerCase(),
              ),
            )
            .toList();
    return _searchList;
  }

  //   static final List<ProductModel> _productsList = [
  //     ProductModel(
  //       id: '01',
  //       title: 'Onyx storm',
  //       author: 'Rebbeca Yarros',
  //       imageUrl: 'https://cdn.dc5.ro/img-prod/4107534701-0-240.jpeg',
  //       productCategoryName: 'Fantasy Books',
  //       price: 30,
  //       isOnFire: true,
  //       description:
  //           'Get ready for the breathtaking follow-up to global phenomenons Fourth Wing and Iron Flame from the no. 1 Sunday Times and New York Times bestselling author Rebecca Yarros. ARE YOU READY TO BRAVE THE DARK? After nearly eighteen months at Basgiath War College, Violet Sorrengail knows there s no more time for lessons. No more time for uncertainty. Because the battle has truly begun, and with enemies closing in from outside their walls and within their ranks, its impossible to know who to trust.Now Violet must journey beyond the failing Aretian wards to seek allies from unfamiliar lands to stand with Navarre. The trip will test every bit of her wit, luck, and strength, but she will do anything to save what she loves - her dragons, her family, her home, and him.Even if it means keeping a secret so big, it could destroy everything.',
  //     ),
  //     ProductModel(
  //       id: '02',
  //       title: 'Iron Flame',
  //       author: 'Rebbeca Yarros',
  //       imageUrl: 'https://cdn.dc5.ro/img-prod/4305915192-0.jpeg',
  //       productCategoryName: 'Fantasy Books',
  //       price: 30,
  //       isOnFire: true,
  //       description: 'this is the description for the Iron Flame book',
  //     ),
  //     ProductModel(
  //       id: '03',
  //       title: 'Business Proposal',
  //       author: 'Narak',
  //       imageUrl: 'https://cdn.dc5.ro/img-prod/2148909103-0.jpeg',
  //       productCategoryName: 'Comics Books',
  //       price: 30,
  //       isOnFire: false,
  //       description: 'this is the description for the Business Proposal comic',
  //     ),
  //     ProductModel(
  //       id: '04',
  //       title: 'Istoria din zorii civilizatiei',
  //       author: 'Adam Hart Davis',
  //       imageUrl: 'https://cdn.dc5.ro/img-prod/4423904693-0.png',
  //       productCategoryName: 'Historical Fiction Books',
  //       price: 30,
  //       isOnFire: false,
  //       description:
  //           'this is the description for the Istoria din zorii covilizatiei book',
  //     ),
  //     ProductModel(
  //       id: '05',
  //       title: 'Duke and I ',
  //       author: 'Julia Quinn',
  //       imageUrl: 'https://cdn.dc5.ro/img-prod/919609548-0.jpeg',
  //       productCategoryName: 'Romance Books',
  //       price: 30,
  //       isOnFire: false,
  //       description: 'this is the description for the The Duke and I book',
  //     ),
  //   ];
}
