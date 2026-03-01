import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/services/api_service.dart';
import '../../../core/utils/api_endpoints.dart';
import '../../../core/utils/api_response.dart';

class HomeController extends GetxController {

  ApiService apiService = Get.find<ApiService>();
  //final ProductController controller = Get.find<ProductController>();

  //TOP BANNERS
  RxBool isBannerLoading = false.obs;
  RxList<String> banners = <String>[].obs;

  //CATEGORIES
  RxBool isCategoryLoading = false.obs;
  //RxList<CategoryModel> categories = <CategoryModel>[].obs;

  //CATEGORY PRODUCTS
  RxBool isCategoryProductsLoading = false.obs;
  //RxList<ProductModel> categoryProducts = <ProductModel>[].obs;

  //TOP FLAVOURS
  RxBool isTopFlavoursLoading = false.obs;
  //RxList<ProductModel> topFlavours = <ProductModel>[].obs;

  //NOTIFICATIONS
  RxBool isNotificationsLoading = false.obs;
  //RxList<NotificationModel> notifications = <NotificationModel>[].obs;

  //PAGINATION
  ScrollController notificationScrollController = ScrollController();
  //PAGINATION
  RxBool isMoreLoading = false.obs;
  int currentPage = 1;
  bool hasMoreData = true;


  @override
  void onInit() {
    if( banners.isEmpty ){
      getBanners();
    }
    // if (categories.isEmpty) {
    //   getCategoryList();
    // }
    // if (topFlavours.isEmpty) {
    //   getTopFlavourProducts();
    // }
    // if( notifications.isEmpty ){
    //   getNotifications();
    // }

    notificationScrollController.addListener((){
      if( notificationScrollController.position.pixels == notificationScrollController.position.maxScrollExtent ){
        if (isMoreLoading.value || !hasMoreData) return;
        // Trigger when user scrolls to 90% of the page
        if ( notificationScrollController.position.pixels >= notificationScrollController.position.maxScrollExtent * 0.9 ) {
          getNotifications(isRefresh: false);
        }
      }
    });
    super.onInit();
  }

  //GET BANNERS
  getBanners() async{
    if( isBannerLoading.value ){
      return;
    }

    isBannerLoading.value = true;
    ApiResponse response = await apiService.networkRequest(
        method: "GET",
        isAuthRequired: true,
        endPoint: ApiEndpoints.getBanners
    );
    if( response.statusCode == 200 ){
      final tempBanners = response.data['data'] as List<dynamic>?;

      if( tempBanners is List && tempBanners.isNotEmpty ){
        banners.value = tempBanners.map<String>((e){
          return e['image'].toString();
        }).toList();
      }
    }
    isBannerLoading.value = false;
  }

  //GET CATEGORY LIST
  getCategoryList() async {
    if (isCategoryLoading.value) {
      return;
    }

    isCategoryLoading.value = true;
    ApiResponse response = await apiService.networkRequest(
        method: "GET",
        isAuthRequired: true,
        endPoint: ApiEndpoints.getAllCategory
    );
    if( response.statusCode == 200 ){
      final tempList = response.data['data']['result'] as List<dynamic>?;
      if( tempList is List && tempList.isNotEmpty ){
        // categories.value = tempList.map<CategoryModel>((e){
        //   return CategoryModel.fromJson(e);
        // }).toList();
      }
    }
    isCategoryLoading.value = false;
  }

  //GET CATEGORY PRODUCTS
  getCategoryProducts({required String categoryId}) async {
    //categoryProducts.assignAll([]);
    if (isCategoryProductsLoading.value) {
      return;
    }

    isCategoryProductsLoading.value = true;
    ApiResponse response = await apiService.networkRequest(
        method: "GET",
        isAuthRequired: true,
        endPoint: ApiEndpoints.getCategoryProducts(categoryId: categoryId)
    );
    if( response.statusCode == 200 ){
      final tempList = response.data['data']['result'] as List<dynamic>?;
      if( tempList is List && tempList.isNotEmpty ){
        // categoryProducts.value = tempList.map<ProductModel>((e){
        //   return ProductModel.fromJson(e);
        // }).toList();
      }
    }
    isCategoryProductsLoading.value = false;
  }

  //GET TOP FLAVOUR PRODUCTS
  getTopFlavourProducts() async {
    if (isTopFlavoursLoading.value) {
      return;
    }
    isTopFlavoursLoading.value = true;
    //topFlavours.value = await controller.getTopFlavourProducts();
    isTopFlavoursLoading.value = false;
  }

  //GET NOTIFICATIONS
getNotifications({bool isRefresh = true}) async{

  if( isNotificationsLoading.value ){
    return;
  }

  if (isRefresh) {
    currentPage = 1;
    hasMoreData = true;
    isNotificationsLoading.value = true;
  } else {
    // If already loading or no more data to fetch, exit
    if (isMoreLoading.value || !hasMoreData) return;
    isMoreLoading.value = true;
  }

    ApiResponse response = await apiService.networkRequest(
        method: "GET",
        isAuthRequired: true,
        endPoint: ApiEndpoints.getNotifications(page: currentPage)
    );
    isNotificationsLoading.value = false;
    isMoreLoading.value = false;
    if( response.statusCode == 200 ){
      final tempNotifications = (response.data['data']['notifications'] as List<dynamic>?) ?? [];
      // List<NotificationModel> fetchedNotifications = tempNotifications.map<NotificationModel>((e){
      //   return NotificationModel.fromJson(e);
      // }).toList();

      // if( isRefresh ){
      //   notifications.value = fetchedNotifications;
      // }else{
      //   notifications.addAll(fetchedNotifications);
      // }
      // if (fetchedNotifications.length < 10) {
      //   hasMoreData = false;
      // } else {
      //   currentPage++;
      // }
    }
}

//NOTIFICATION MARK AS READ
  notificationMarkAsRead({required String notificationId}) async{

    await apiService.networkRequest(
        method: "PATCH",
        isAuthRequired: true,
        endPoint: ApiEndpoints.notificationMarkAsRead(notificationId: notificationId),
      body: {}
    );
  }
}