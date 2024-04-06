import 'package:get_it/get_it.dart';
import 'package:mxe_mobile/core/services/app-cache.dart';
import 'package:mxe_mobile/core/services/app-settings.dart';
import 'package:mxe_mobile/core/services/auth-repository.dart';
import 'package:mxe_mobile/core/services/bills-repository.dart';
import 'package:mxe_mobile/core/services/biometrics-service.dart';
import 'package:mxe_mobile/core/services/encryption-service.dart';
import 'package:mxe_mobile/core/services/navigation_service.dart';
import 'package:mxe_mobile/core/services/storage-service.dart';
import 'package:mxe_mobile/core/services/transfer-repository.dart';
import 'package:mxe_mobile/core/services/user.service.dart';
import 'package:mxe_mobile/core/services/web-services/auth.api.dart';
import 'package:mxe_mobile/core/services/web-services/beneficiary-api.dart';
import 'package:mxe_mobile/core/services/web-services/transactions-api-service.dart';
import 'package:mxe_mobile/core/services/web-services/transfer-api-service.dart';
import 'package:mxe_mobile/core/services/web-services/upload-api.dart';
import 'package:mxe_mobile/core/services/web-services/user-api-service.dart';
import 'package:mxe_mobile/ui/auth/create-pin/create-pin.vm.dart';
import 'package:mxe_mobile/ui/auth/login/login.vm.dart';
import 'package:mxe_mobile/ui/auth/signup/signup.vm.dart';
import 'package:mxe_mobile/ui/auth/verify-otp/verify-otp.vm.dart';
import 'package:mxe_mobile/ui/bills/airtime/airtime.vm.dart';
import 'package:mxe_mobile/ui/bills/betting/betting.vm.dart';
import 'package:mxe_mobile/ui/bills/bills-beneficiaries/bills-beneficiaries.vm.dart';
import 'package:mxe_mobile/ui/bills/bills.vm.dart';
import 'package:mxe_mobile/ui/bills/cable/cable.vm.dart';
import 'package:mxe_mobile/ui/bills/data/data.vm.dart';
import 'package:mxe_mobile/ui/bills/electricity/electricity.vm.dart';
import 'package:mxe_mobile/ui/cards/card.vm.dart';
import 'package:mxe_mobile/ui/crypto/home/home-tab.vm.dart';
import 'package:mxe_mobile/ui/crypto/home/home.vm.dart';
import 'package:mxe_mobile/ui/crypto/home/wallet/wallet.vm.dart';
import 'package:mxe_mobile/ui/crypto/intro/crypto-onboarding.vm.dart';
import 'package:mxe_mobile/ui/home/convert/convert.vm.dart';
import 'package:mxe_mobile/ui/home/deposit/add-card/card.vm.dart';
import 'package:mxe_mobile/ui/home/deposit/deposit.vm.dart';
import 'package:mxe_mobile/ui/home/finance/finance.vm.dart';
import 'package:mxe_mobile/ui/home/home-tab.vm.dart';
import 'package:mxe_mobile/ui/home/home.vm.dart';
import 'package:mxe_mobile/ui/home/insights/insights.vm.dart';
import 'package:mxe_mobile/ui/home/notification/notification.vm.dart';
import 'package:mxe_mobile/ui/home/request/request.vm.dart';
import 'package:mxe_mobile/ui/home/save-usd/save-usd.vm.dart';
import 'package:mxe_mobile/ui/home/send/send.vm.dart';
import 'package:mxe_mobile/ui/home/verification/verification.vm.dart';
import 'package:mxe_mobile/ui/onboarding/onboarding.vm.dart';
import 'package:mxe_mobile/ui/profile/beneficiaries/beneficiaries.vm.dart';
import 'package:mxe_mobile/ui/profile/change-pin/change-pin.vm.dart';
import 'package:mxe_mobile/ui/profile/notification/notification-vm.dart';
import 'package:mxe_mobile/ui/profile/profile.vm.dart';
import 'package:mxe_mobile/ui/profile/saved-cards/saved-card.vm.dart';
import 'package:mxe_mobile/ui/profile/schedule-payment/schedule-payment.vm.dart';
import 'package:mxe_mobile/ui/profile/statement/statement.vm.dart';
import 'package:mxe_mobile/utils/initializer.dart';
import 'package:mxe_mobile/widgets/transaction-pin/transfer-pin.vm.dart';

GetIt getIt = GetIt.I;

dependenciesInjectorSetup() {
  //View Model

  //Auth ViewModels
  getIt.registerFactory<OnBoardingViewModel>(() => OnBoardingViewModel());
  getIt.registerFactory<LoginViewModel>(() => LoginViewModel());
  getIt.registerFactory<SignupViewModel>(() => SignupViewModel());
  getIt.registerFactory<HomeViewModel>(() => HomeViewModel());
  getIt.registerFactory<HomeTabViewModel>(() => HomeTabViewModel());
  getIt.registerFactory<InsightsViewModel>(() => InsightsViewModel());
  getIt.registerFactory<NotificationsViewModel>(() => NotificationsViewModel());
  getIt.registerFactory<DepositViewModel>(() => DepositViewModel());
  getIt.registerFactory<AddCardViewModel>(() => AddCardViewModel());
  getIt.registerFactory<VerificationViewModel>(() => VerificationViewModel());
  getIt.registerFactory<BillsViewModel>(() => BillsViewModel());
  getIt.registerFactory<BuyAirtimeViewModel>(() => BuyAirtimeViewModel());
  getIt.registerFactory<BillsBeneficiariesViewModel>(
      () => BillsBeneficiariesViewModel());
  getIt.registerFactory<BuyDataViewModel>(() => BuyDataViewModel());
  getIt.registerFactory<BuyElectricityViewModel>(
      () => BuyElectricityViewModel());
  getIt.registerFactory<PayBettingViewModel>(() => PayBettingViewModel());
  getIt.registerFactory<PayCableViewModel>(() => PayCableViewModel());
  getIt.registerFactory<CardViewModel>(() => CardViewModel());
  getIt.registerFactory<SendFundsViewModel>(() => SendFundsViewModel());
  getIt.registerFactory<ConvertFundsViewModel>(() => ConvertFundsViewModel());
  getIt.registerFactory<ProfileViewModel>(() => ProfileViewModel());
  getIt.registerFactory<RequestViewModel>(() => RequestViewModel());
  getIt.registerFactory<BeneficiariesViewModel>(() => BeneficiariesViewModel());
  getIt.registerFactory<ChangePinViewModel>(() => ChangePinViewModel());
  getIt.registerFactory<SavedCardViewModel>(() => SavedCardViewModel());
  getIt.registerFactory<FinanceViewModel>(() => FinanceViewModel());
  getIt.registerFactory<AccountStatementViewModel>(
      () => AccountStatementViewModel());
  getIt.registerFactory<SchedulePaymentViewModel>(
      () => SchedulePaymentViewModel());
  getIt.registerFactory<SaveInUsdViewModel>(() => SaveInUsdViewModel());

  getIt.registerFactory<OtpVerificationViewModel>(
      () => OtpVerificationViewModel());

  getIt.registerFactory<TransferPinViewModel>(() => TransferPinViewModel());
  getIt.registerFactory<NotificationViewModel>(() => NotificationViewModel());
  getIt.registerFactory<CryptoOnboardingViewModel>(
      () => CryptoOnboardingViewModel());
  getIt.registerFactory<CryptoHomeViewModel>(() => CryptoHomeViewModel());
  getIt.registerFactory<CryptoHomeTabViewModel>(() => CryptoHomeTabViewModel());
  getIt.registerFactory<CryptoWalletViewModel>(() => CryptoWalletViewModel());
  // Services

  getIt.registerLazySingleton<NavigationService>(() => NavigationService());
  getIt.registerLazySingleton(() => Initializer());
  getIt.registerLazySingleton(() => UserService());
  getIt.registerLazySingleton(() => AppCache());
  getIt.registerLazySingleton(() => TransferRepository());
  // OtpVerificationViewModel

  getIt.registerLazySingleton(() => EncryptionService());
  getIt.registerLazySingleton(() => BioMetricsService());
  getIt.registerLazySingleton(() => AppSettings());
  getIt.registerLazySingleton<StorageService>(() => StorageService());
  getIt.registerLazySingleton<AuthenticationApiService>(() =>
      AuthenticationApiService(
          getIt<StorageService>(), getIt<AuthenticationRepository>()));

  getIt.registerLazySingleton<UploadApiService>(() => UploadApiService(
      authenticationRepository: getIt<AuthenticationRepository>(),
      userService: getIt<UserService>(),
      cache: getIt<AppCache>()));

  getIt.registerLazySingleton<TransactionsApiService>(() =>
      TransactionsApiService(
          authenticationRepository: getIt<AuthenticationRepository>()));

  getIt.registerLazySingleton<BeneficiaryApiService>(
      () => BeneficiaryApiService());

  getIt.registerLazySingleton<CreatePinViewModel>(() => CreatePinViewModel());

  getIt.registerLazySingleton<UserApiService>(() => UserApiService(
      authenticationRepository: getIt<AuthenticationRepository>()));
  getIt.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepository(getIt<StorageService>()));
  getIt.registerLazySingleton<TransferApiService>(() => TransferApiService(
      authenticationRepository: getIt<AuthenticationRepository>()));
  getIt.registerLazySingleton<BillsRepository>(() => BillsRepository());

//  ChangePasswordViewModel
}
