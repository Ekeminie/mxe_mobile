class ApiRoutes {
  static const String registerPhoneNumber = "auth/UserSignup";
  static const String verifyCode =
      "auth/userification/verify-signup-or-login-code";
  static String resendOtpCode(String id) => "users/userResend-otp-code/$id";
  static String updateUser(String? id) => "users/user/$id";
  static const String loginRoute = "auth/Userlogin";
  static const String savedLoginRoute = "auth/SavedUserLogin";
  static const String generateRandomMxeTags = "users/generate-random-mxe-tags";
  static const String addPasswordAfterLogin =
      "users/add-password/add-password-after-signup";
  static const String changePin = "users/verification/change-password";

  ///Beneficiary
  static const String createAirtimeAndDataBeneficiary =
      "beneficiaries/create-airtime-and-data-beneficiary";
  static String getAirtimeAndDataBeneficiary(String id) =>
      "beneficiaries/beneficiaries/airtime-and-data/$id";
  static String deleteAirtimeAndDataBeneficiary(String id) =>
      "/beneficiaries/airtime-and-data-beneficiary/$id";
  static const String createWithdrawalBeneficiary =
      "beneficiaries/create-withdrawal-beneficiary";
  static String getWithdrawalBeneficiary(String id) =>
      "beneficiaries/beneficiaries/withdrawal/$id";
  static String deleteWithdrawalBeneficiary(String id) =>
      "beneficiaries/withdrawal-beneficiary/$id";

  static const String signUpRoute = "auth/sign-up";
  static const String addMxeTag = "users/add-mxe-tag/add-user-mxe-tag";
  static const String getNotifications = "notification";
  static String getNotificationById(String id) => "notification/$id";
  static const String getInflowAndOutFlow =
      "dashboardandinsights/get-user-inflow-and-outflow";
  static const String getUserStatisticsAndInsights =
      "dashboardandinsights/get-user-statistisc-insights";
  static String getUserTransactions(String id) => "transaction/export-soa/$id";
  static String getTransactionReceipt(String id) =>
      "transaction/download-receipt/$id";
  static String getTransactionSoa(String id) => "transaction/download-soa/$id";
  static const String searchUserName =
      "requestsfund/search-for-user-tag/search";
  static const String requestFunds = "requestsfund";
  static String requestFundsHistory(String id) => "/requestsfund/$id";

  static const String uploadFiles = "upload-files";

  static const String createCard = "virtual-card";
  static String getCard(String id) => "virtual-card/$id";
  static String freezeCard(String id) => "virtual-card/$id/freeze";

  ///Bills Route
  static const String purchaseAirtime = "bill/airtime-purchase";
  static const String dataPurchase = "bill/data-purchase";
  static const String cablePurchase = "bill/cable-purchase";
  static const String electricityPurchase = "bill/electricity-purchase";
  static const String getInternetProviders =
      "bill/get-all-providers/internet-providers";
  static String findDataPlansByProvider(String provider) =>
      "bill/data-purchase/find-plans/$provider";
  static const String getCableProviders =
      "bill/get-all-providers/cable-providers";
  static String getCablePlan(String provider) =>
      "bill/cable-purchase/find-plans/$provider";
  static String verifyCableId(String provider, String deviceId) =>
      "bill/verify-cable-id/$provider/$deviceId";
  static const String getElectricityProviders =
      "/bill/get-all-providers/Electricity-providers";
  static String verifyMeterNumber(
          String provider, String meterNo, String meterType) =>
      "/bill/verify-cable-id/$provider/$meterNo/$meterType";

  ///

  ///Withdrawals and Transfers
  static const String getBanks = "withdrawal/banks";
  static const String resolveAccount = "withdrawal/resolve-account";
  static const String withdrawal = "withdrawal/";
  static const String withdrawWithMxeTag =
      "withdrawal/make-withdrawal-with-mxe-tag";

  ///
  ///

  static const String verifyEmailOTP = 'otp/verify-email-otp';
  static String getUser(String id) => 'users/user-details/$id';
  static String requestForgotPasswordOTP(String phone) =>
      'users/verification/initiate-forgot-password-flow/$phone';
  static String verifyForgotPasswordOTP(String code) =>
      'users/verification/finalize-forgot-password-flow/$code';
  static const String resetPasswordRoute = "users/verification/change-password";
  static const String updateForgotPassword = 'auth/update-password';
  static const String requestEmailOTP = 'otp/create-email-otp';
  static const String requestPasswordReset = 'auth/request/reset';
  static const String requestPasswordResetOTP = 'auth/request/reset-otp';
  static const String validatePasswordResetOTP = "auth/verify/reset-otp";
  static const String resetPassword = 'auth/reset';
  static const String verifyEmail = 'auth/verify/email';
}
