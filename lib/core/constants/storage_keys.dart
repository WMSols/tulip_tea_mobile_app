/// Keys for secure storage and in-memory cache.
class StorageKeys {
  StorageKeys._();

  static const String accessToken = 'access_token';
  static const String tokenType = 'token_type';
  static const String user = 'user';
  static const String onboardingCompleted = 'onboarding_completed';
  static const String deliveryManOnboardingCompleted =
      'delivery_man_onboarding_completed';
  static const String userRole = 'user_role';
  
  // Remember Me - Role-specific keys
  static const String rememberMeOrderBooker = 'remember_me_order_booker';
  static const String rememberMeDeliveryMan = 'remember_me_delivery_man';
  static const String rememberedPhoneOrderBooker = 'remembered_phone_ob';
  static const String rememberedPhoneDeliveryMan = 'remembered_phone_dm';
  static const String rememberedPasswordOrderBooker = 'remembered_password_ob';
  static const String rememberedPasswordDeliveryMan = 'remembered_password_dm';

  // User roles
  static const String roleOrderBooker = 'order_booker';
  static const String roleDeliveryMan = 'delivery_man';
}
