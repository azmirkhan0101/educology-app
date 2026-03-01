class ApiEndpoints {

  ApiEndpoints._();

  //=======================BASE====================================
  //BASE URL
  //static const baseUrl = "https://el-afrik-seven.vercel.app/api/v1";
  static const baseUrl = "https://lms-orpin-five.vercel.app/api/v1";

  //=======================AUTH====================================
  //LOGIN/SIGNIN
  static const login = "/auth/login";
  //SIGNUP
  static const signup = "/auth/register";
  //SEND FORGOT PASSWORD OTP
  static const otpForgotPassword = "/auth/forgotPass";
  //RESEND OTP
  static const otpResend = "/auth/resendOtp";
  //VERIFY SIGNUP OTP
  static const verifySignupOtp = "/auth/regOtpVerify";
  //VERIFY FORGOT PASSWORD OTP
  static const otpVerifyForgotPassword = "/auth/verifyOtp";
  //RESET PASSWORD - NEW PASSWORD
  static const resetPassword = "/auth/resetPass";

  //REFRESH TOKEN
  static const refreshToken = "/auth/refresh-token";


  static const uploadExam = "/uploadExam";

  //=======================PROFILE=================================
  //GET PROFILE
  static const getProfile = "/user/my-profile";
  //CHANGE PASSWORD - UPDATE PASSWORD
  static const changePassword = "/auth/changePassword";
  //DELETE ACCOUNT
  static const deleteAccount = "/user/delete-profile";
  //UPDATE PROFILE
  static const updateProfile = "/user/edit-profile";

  //=========================PRODUCTS==============================
  static const getAllProducts = "/product/allProduct";
  static String getPromoEventProducts({required String type}){
    return "/promos/all?type=$type";
  }
  static String searchProducts({required String query}){
    return "/product/allProduct?status=in_stock&search=$query";
  }
  static const getRewardProducts = "/product/allProduct?isRedem=true&status=in_stock";
static String getProductDetails({required String productId}) {
  return "/product/single-product/$productId}";
}
static const redeemRewards = "/redeem/purchase";
static String topFlavourProduct({required int page}){
  return "/product/allProduct/?isFeatured=true&status=in_stock&page=$page&limit=10";
}

//=========================CART========================================
  static const getCartItems = "/cart/all-item";
  static const addItemToCart = "/cart/add-item";
  static String updateCartItems({required String productId}) {
    return "/cart/update-item/$productId";
  }
  static String removeItemFromCart({required String id}){
    return "/cart/remove-item/$id";
  }
  static const clearCart = "/cart/clear-cart";

  //=======================CATERING==================================
  static const getCateringPackages = "/catering/packages";
  static const getBookedCateringPackages = "/catering/my-bookings";
  static const cateringRequest = "/catering/reserve";

  //=======================BANNER===================================
  static const getBanners = "/ads/all-ads";

//=========================CATEGORY==================================
  static const getAllCategory = "/category/allCategory";
  static String getCategoryProducts({required String categoryId}){
    return "/product/allProduct?category=$categoryId";
  }

//=========================WISHLIST==================================
  static const getWishList = "/wishlist/mine";
  static String addItemToWishList({required String id}){
    return "/wishlist/add/$id";
  }
  static String removeItemFromWishlist({required String id}){
    return "/wishlist/remove/$id";
  }

//=========================CHECKOUT==================================
  static const checkout = "/order/checkout";

  //DELIVERY
  static const getDeliveryFee = "/order/get-delivery-fee";
  //GET STRIPE SESSION - BUY NOW
  static const getBuyNowStripeSession = "/order/buy-now";
  //PROMO CODE BUY NOW
  static const promoCodeBuyNow = "/order/promo-buy-now";
  //GET STRIPE SESSION - CHECKOUT
  static const getCheckOutStripeSession = "/order/checkout";

  //==========================ORDER=================================
  static String getOrders({required String orderStatus, required bool isOngoing, required int page}){
    return "/order/my-orders?status=$orderStatus&page=$page&limit=10";
  }
  static String getRating({required String productId}){
    return "/product/rating-summary/$productId";
  }

  static const submitRating = "/product/add-review";

  //=====================NOTIFICATION================================
  static String getNotifications({required int page}){
    return "/notification/my-notifications/?page=$page&limit=10";
  }
  static String notificationMarkAsRead({required String notificationId}){
    return "/notification/mark-as-read/$notificationId";
  }

  //=====================QR CLAIM===================================
  static const qrClaim = "/qrcode/claim";

  //======================POINTS HISTORY============================
  static String getPointsHistory({required String type}){
    return "/reward/my-history?type=$type";
  }

  //=====================BIRTHDAY====================================
  static const claimBirthdayReward = "/birthday/activate-claim";

//=========================FAQ========================================
  static const String faq = "/faq/allFaq";
  //=========================PRIVACY POLICY===========================
  static const String privacyPolicy = "/privacy/retrive";
//=========================TERMS AND CONDITIONS=======================
  static const String termsAndConditions = "/terms/retrive";
}
