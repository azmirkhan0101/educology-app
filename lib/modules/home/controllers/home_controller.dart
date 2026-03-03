import 'package:dr_dina_educology/core/services/role_service.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:get/get.dart';

import '../../../core/services/api_service.dart';
import '../../../core/utils/api_endpoints.dart';
import '../../../core/utils/api_response.dart';

class HomeController extends GetxController {

  //GET DATA BASED ON USER ROLE
  final RoleService roleService = Get.find<RoleService>();
  final ApiService apiService = Get.find<ApiService>();

  late Role role;

  //COURSE COUNTS FOR TEACHER AND ASSISTANT
  RxBool isCourseCountLoading = false.obs;
  RxInt courseCount = 0.obs;
  RxInt studentCount = 0.obs;

  @override
  void onInit() {

    role = roleService.getUpdatedRole();

    if( role == Role.teacher || role == Role.assistant ){
      getCourseCounts();
    }
    super.onInit();
  }

  //GET COURSE COUNTS
  Future<void> getCourseCounts() async{
    if( isCourseCountLoading.value ){
      return;
    }

    isCourseCountLoading.value = true;
    ApiResponse response = await apiService.networkRequest(
        method: "GET",
        isAuthRequired: true,
        endPoint: ApiEndpoints.getBanners//TODO: CHANGE ENDPOINT
    );
    if( response.statusCode == 200 ){
      final tempBanners = response.data['data'] as List<dynamic>?;

      if( tempBanners is List && tempBanners.isNotEmpty ){
        // banners.value = tempBanners.map<String>((e){
        //   return e['image'].toString();
        // }).toList();
      }
    }
    isCourseCountLoading.value = false;
  }

  //GET CATEGORY LIST
  // getCategoryList() async {
  //   if (isCategoryLoading.value) {
  //     return;
  //   }
  //
  //   isCategoryLoading.value = true;
  //   ApiResponse response = await apiService.networkRequest(
  //       method: "GET",
  //       isAuthRequired: true,
  //       endPoint: ApiEndpoints.getAllCategory
  //   );
  //   if( response.statusCode == 200 ){
  //     final tempList = response.data['data']['result'] as List<dynamic>?;
  //     if( tempList is List && tempList.isNotEmpty ){
  //       // categories.value = tempList.map<CategoryModel>((e){
  //       //   return CategoryModel.fromJson(e);
  //       // }).toList();
  //     }
  //   }
  //   isCategoryLoading.value = false;
  // }

  //GET CATEGORY PRODUCTS
  // getCategoryProducts({required String categoryId}) async {
  //   //categoryProducts.assignAll([]);
  //   if (isCategoryProductsLoading.value) {
  //     return;
  //   }
  //
  //   isCategoryProductsLoading.value = true;
  //   ApiResponse response = await apiService.networkRequest(
  //       method: "GET",
  //       isAuthRequired: true,
  //       endPoint: ApiEndpoints.getCategoryProducts(categoryId: categoryId)
  //   );
  //   if( response.statusCode == 200 ){
  //     final tempList = response.data['data']['result'] as List<dynamic>?;
  //     if( tempList is List && tempList.isNotEmpty ){
  //       // categoryProducts.value = tempList.map<ProductModel>((e){
  //       //   return ProductModel.fromJson(e);
  //       // }).toList();
  //     }
  //   }
  //   isCategoryProductsLoading.value = false;
  // }

  //GET TOP FLAVOUR PRODUCTS
  // getTopFlavourProducts() async {
  //   if (isTopFlavoursLoading.value) {
  //     return;
  //   }
  //   isTopFlavoursLoading.value = true;
  //   //topFlavours.value = await controller.getTopFlavourProducts();
  //   isTopFlavoursLoading.value = false;
  // }
}