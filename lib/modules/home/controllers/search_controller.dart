import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/services/api_service.dart';

class SearchController extends GetxController {

  Timer? _debounce;
  final ApiService apiService = ApiService();
  RxBool isLoading = false.obs;
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    setupSearchListener();
    super.onInit();
  }

  void setupSearchListener() {
    searchController.addListener(() {
      _onSearchChanged(searchController.text.trim());
    });
  }

  void _onSearchChanged(String query) {
    // Cancel the previous timer if the user types again within 800ms
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (query.isNotEmpty) {
        searchProducts(query: query);
      }
    });
  }

  //SEARCH
Future<void> searchProducts({required String query}) async{

    isLoading.value = true;
    // ApiResponse response = await apiService.networkRequest(
    //     method: "GET",
    //     isAuthRequired: true,
    //     endPoint: ApiEndpoints.searchProducts(query: query)
    // );
    // if( response.statusCode == 200 ){
    //   final tempList = response.data['data']['result'] as List<dynamic>?;
    //   // searchResults.value = tempList?.map<ProductModel>((e){
    //   //   return ProductModel.fromJson(e);
    //   // }).toList() ?? [];
    // }
    isLoading.value = false;

}

  @override
  void onClose() {
    _debounce?.cancel();
    searchController.dispose();
    super.onClose();
  }
}