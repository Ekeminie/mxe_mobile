import 'package:flutter/material.dart';
import 'package:mxe_mobile/core/model/airtime-and-data-beneficiary-response.dart';
import 'package:mxe_mobile/core/model/request/auth.dart';
import 'package:mxe_mobile/core/model/withdrawal-beneficiary-response.dart';
import 'package:mxe_mobile/routes/router-utils.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/auth/create-pin/confirm-pin.ui.dart';
import 'package:mxe_mobile/ui/auth/create-pin/create-pin.dart';
import 'package:mxe_mobile/ui/auth/login/lock-page.dart';
import 'package:mxe_mobile/ui/auth/login/login.ui.dart';
import 'package:mxe_mobile/ui/auth/login/new-user/phone-number-auth.dart';
import 'package:mxe_mobile/ui/auth/login/old-user/welcome-back.dart';
import 'package:mxe_mobile/ui/auth/reset-pin/reset-otp.ui.dart';
import 'package:mxe_mobile/ui/auth/reset-pin/reset-pin.ui.dart';
import 'package:mxe_mobile/ui/auth/signup/signup.ui.dart';
import 'package:mxe_mobile/ui/auth/signup/singup-details.ui.dart';
import 'package:mxe_mobile/ui/auth/verify-otp/verify-otp.ui.dart';
import 'package:mxe_mobile/ui/beneficiary/transfer-beneficiary.dart';
import 'package:mxe_mobile/ui/bills/airtime/airtime.ui.dart';
import 'package:mxe_mobile/ui/bills/airtime/review-airtime.ui.dart';
import 'package:mxe_mobile/ui/bills/betting/betting.ui.dart';
import 'package:mxe_mobile/ui/bills/betting/review-betting.ui.dart';
import 'package:mxe_mobile/ui/bills/bills-beneficiaries/bills-beneficiaries.ui.dart';
import 'package:mxe_mobile/ui/bills/bills.ui.dart';
import 'package:mxe_mobile/ui/bills/cable/cable.ui.dart';
import 'package:mxe_mobile/ui/bills/cable/review-cable.ui.dart';
import 'package:mxe_mobile/ui/bills/data/data.ui.dart';
import 'package:mxe_mobile/ui/bills/data/review-data.ui.dart';
import 'package:mxe_mobile/ui/bills/electricity/electricity.ui.dart';
import 'package:mxe_mobile/ui/bills/electricity/review-electricity.ui.dart';
import 'package:mxe_mobile/ui/cards/create-card/create-card.ui.dart';
import 'package:mxe_mobile/ui/cards/topup.ui.dart';
import 'package:mxe_mobile/ui/cards/withdraw.ui.dart';
import 'package:mxe_mobile/ui/crypto/home/backup/backup.ui.dart';
import 'package:mxe_mobile/ui/crypto/home/bottom_nav_page.dart';
import 'package:mxe_mobile/ui/crypto/home/drawer-menu.dart';
import 'package:mxe_mobile/ui/crypto/home/wallet/manage-wallet.dart';
import 'package:mxe_mobile/ui/crypto/home/wallet/view-wallet.dart';
import 'package:mxe_mobile/ui/crypto/intro/crypto-onboarding.dart';
import 'package:mxe_mobile/ui/crypto/notifications/crypto-notifications.io.dart';
import 'package:mxe_mobile/ui/crypto/recieve/receive-asset.ui.dart';
import 'package:mxe_mobile/ui/crypto/trade/crypto-trade/crypto-trade.ui.dart';
import 'package:mxe_mobile/ui/crypto/trade/currency/about-currency.dart';
import 'package:mxe_mobile/ui/crypto/trade/currency/currency-view-page.dart';
import 'package:mxe_mobile/ui/crypto/trade/giftcard-trade/add-account/add-account.dart';
import 'package:mxe_mobile/ui/crypto/trade/giftcard-trade/giftcard-details.ui.dart';
import 'package:mxe_mobile/ui/crypto/trade/giftcard-trade/giftcard-success.dart';
import 'package:mxe_mobile/ui/home/bottom_nav_page.dart';
import 'package:mxe_mobile/ui/home/convert/conversion-success.dart';
import 'package:mxe_mobile/ui/home/convert/convert.ui.dart';
import 'package:mxe_mobile/ui/home/deposit/add-card/add-card.ui.dart';
import 'package:mxe_mobile/ui/home/deposit/add-card/payment-success.dart';
import 'package:mxe_mobile/ui/home/deposit/add-card/transaction-details.ui.dart';
import 'package:mxe_mobile/ui/home/deposit/crypto/fund-with-crypto.ui.dart';
import 'package:mxe_mobile/ui/home/deposit/deposit.ui.dart';
import 'package:mxe_mobile/ui/home/drawer-menu.dart';
import 'package:mxe_mobile/ui/home/insights/insights.ui.dart';
import 'package:mxe_mobile/ui/home/notification/notifications.ui.dart';
import 'package:mxe_mobile/ui/home/request/request-amount.ui.dart';
import 'package:mxe_mobile/ui/home/request/request.ui.dart';
import 'package:mxe_mobile/ui/home/save-usd/save-usd-confirmation.dart';
import 'package:mxe_mobile/ui/home/save-usd/save-usd.ui.dart';
import 'package:mxe_mobile/ui/home/save-usd/save/save.ui.dart';
import 'package:mxe_mobile/ui/home/save-usd/withdraw/withdraw.ui.dart';
import 'package:mxe_mobile/ui/home/send/send-details.ui.dart';
import 'package:mxe_mobile/ui/home/send/send.ui.dart';
import 'package:mxe_mobile/ui/home/send/transfer-details.dart';
import 'package:mxe_mobile/ui/home/verification/verification-into.ui.dart';
import 'package:mxe_mobile/ui/onboarding/onboarding.ui.dart';
import 'package:mxe_mobile/ui/profile/beneficiaries/beneficiaries.ui.dart';
import 'package:mxe_mobile/ui/profile/beneficiaries/edit-bills-beneficiaries.dart';
import 'package:mxe_mobile/ui/profile/beneficiaries/edit-transfer-beneficiaries.dart';
import 'package:mxe_mobile/ui/profile/change-pin/change-pin.ui.dart';
import 'package:mxe_mobile/ui/profile/close-account/close-account-success.dart';
import 'package:mxe_mobile/ui/profile/close-account/close-account.ui.dart';
import 'package:mxe_mobile/ui/profile/edit-profile/edit-profile.ui.dart';
import 'package:mxe_mobile/ui/profile/help/help.ui.dart';
import 'package:mxe_mobile/ui/profile/notification/notification.ui.dart';
import 'package:mxe_mobile/ui/profile/saved-cards/add-new-card.ui.dart';
import 'package:mxe_mobile/ui/profile/saved-cards/new-card-verification.ui.dart';
import 'package:mxe_mobile/ui/profile/saved-cards/saved-cards.ui.dart';
import 'package:mxe_mobile/ui/profile/schedule-payment/edit-schedule-payment.ui.dart';
import 'package:mxe_mobile/ui/profile/schedule-payment/schedule-payment.ui.dart';
import 'package:mxe_mobile/ui/profile/statement/statement.ui.dart';
import 'package:mxe_mobile/widgets/notifications-handler.dart';
import 'package:mxe_mobile/widgets/transaction-success/transaction-success-widget.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.onboardingPageRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingPage());
      case Routes.phoneAuthPage:
        return MaterialPageRoute(builder: (_) => const PhoneNumberAuthPage());
      case Routes.oTPPageRoute:
        String? data = args as String?;
        return MaterialPageRoute(builder: (_) => VerifyOtp(route: data));
      case Routes.welcomeRoute:
        return MaterialPageRoute(builder: (_) => const WelcomeBackPage());
      case Routes.lockPageRoute:
        return MaterialPageRoute(builder: (_) => const LockPage());
      case Routes.resetPinPageRoute:
        return MaterialPageRoute(builder: (_) => const ResetPinPage());
      case Routes.resetPinOtpPageRoute:
        return MaterialPageRoute(builder: (_) => const ResetPinOtp());
      case Routes.createPinRoute:
        return MaterialPageRoute(builder: (_) => const CreateNewPinPage());
      case Routes.confirmPinRoute:
        return MaterialPageRoute(builder: (_) => const ConfirmPinPage());
      case Routes.notificationHandler:
        String? data = args as String?;
        return MaterialPageRoute(
            builder: (_) => NotificationWidgetHandler(
                  destinationRoute: data ?? Routes.loginRoute,
                ));
      case Routes.loginRoute:
        Map? data = args as Map?;
        return MaterialPageRoute(
            builder: (_) => LoginPage(
                  request: data?['loginRequest'] as LoginRequest?,
                ));
      case Routes.signupRoute:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case Routes.signupDetailsRoute:
        return MaterialPageRoute(builder: (_) => const SignUpDetailsPage());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const BottomNavPage());
      case Routes.navDrawerRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const NavDrawerMenu(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(-1, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      // return MaterialPageRoute(builder: (_) => const NavDrawerMenu());
      case Routes.insightsPageRoute:
        return MaterialPageRoute(builder: (_) => const InsightsTabPage());
      case Routes.notificationsPageRoute:
        return MaterialPageRoute(builder: (_) => const NotificationsTabPage());
      case Routes.fundAccountPageRoute:
        return MaterialPageRoute(builder: (_) => const DepositPage());
      case Routes.sendFundsAccountPageRoute:
        return MaterialPageRoute(builder: (_) => const SendFundsPage());
      case Routes.sendFundsDetailsPageRoute:
        return MaterialPageRoute(builder: (_) => const SendFundsDetailsPage());
      case Routes.transferDetailsPageRoute:
        return MaterialPageRoute(builder: (_) => const TransferDetailsPage());
      case Routes.convertFundsPageRoute:
        return MaterialPageRoute(builder: (_) => const ConvertFundsPage());
      case Routes.convertFundsSuccessPageRoute:
        return MaterialPageRoute(builder: (_) => const ConversionSuccess());
      case Routes.requestFundsPageRoute:
        return MaterialPageRoute(builder: (_) => const RequestPage());
      case Routes.requestFundsDetailsPageRoute:
        return MaterialPageRoute(builder: (_) => const RequestDetailsPage());
      case Routes.addCardPageRoute:
        return MaterialPageRoute(builder: (_) => const AddCardPage());
      case Routes.accountVerificationPageRoute:
        return MaterialPageRoute(builder: (_) => const VerificationIntroPage());
      case Routes.fundAccountSuccessPageRoute:
        return MaterialPageRoute(builder: (_) => const FundPaymentSuccess());
      case Routes.fundAccountTransactionsDetailsPageRoute:
        return MaterialPageRoute(builder: (_) => const TransactionDetails());
      case Routes.fundWithCryptoPageRoute:
        return MaterialPageRoute(builder: (_) => const FundWithCryptoPage());
      case Routes.billsPageRoute:
        return MaterialPageRoute(builder: (_) => const BillsPage());
      case Routes.airtimePageRoute:
        return MaterialPageRoute(builder: (_) => const BuyAirtimePage());
      case Routes.billsBeneficiaryPageRoute:
        return MaterialPageRoute(builder: (_) => const BillsBeneficiaries());
      case Routes.reviewAirtimePageRoute:
        return MaterialPageRoute(builder: (_) => const ReviewAirtimePage());
      case Routes.dataPageRoute:
        return MaterialPageRoute(builder: (_) => const BuyDataPage());
      case Routes.reviewDataPageRoute:
        return MaterialPageRoute(builder: (_) => const ReviewDataPage());

      case Routes.electricityPageRoute:
        return MaterialPageRoute(builder: (_) => const BuyElectricityPage());
      case Routes.reviewElectricityPageRoute:
        return MaterialPageRoute(builder: (_) => const ReviewElectricityPage());

      case Routes.cablePageRoute:
        return MaterialPageRoute(builder: (_) => const PayCablePage());
      case Routes.reviewCablePageRoute:
        return MaterialPageRoute(builder: (_) => const ReviewCablePage());

      case Routes.bettingPageRoute:
        return MaterialPageRoute(builder: (_) => const PayBettingPage());
      case Routes.reviewBettingPageRoute:
        return MaterialPageRoute(builder: (_) => const ReviewBettingPage());
      case Routes.createCardPageRoute:
        return MaterialPageRoute(builder: (_) => const CreateCardPage());
      case Routes.fundVirtualCardPageRoute:
        return MaterialPageRoute(builder: (_) => const VirtualCardTopup());
      case Routes.withdrawFromVirtualCardPageRoute:
        return MaterialPageRoute(builder: (_) => const VirtualCardWithdrawal());

      case Routes.transactionSuccessPageRoute:
        SuccessData? data = args as SuccessData?;
        return MaterialPageRoute(
            builder: (_) => TransactionSuccessPage(
                  data: data ?? SuccessData(),
                ));

      case Routes.editProfilePageRoute:
        return MaterialPageRoute(builder: (_) => const EditProfilePage());
      case Routes.notificationPagePreferencesRoute:
        return MaterialPageRoute(
            builder: (_) => const NotificationPreferencePage1());
      case Routes.beneficiariesPageRoute:
        return MaterialPageRoute(builder: (_) => const BeneficiariesTabPage());
      case Routes.editBeneficiaryRoute:
        WithdrawalBeneficiary data = args as WithdrawalBeneficiary;
        return MaterialPageRoute(
            builder: (_) => EditTBeneficiaryPage(
                  item: data,
                ));
      case Routes.editBillsBeneficiaryRoute:
        AirtimeDataBeneficiaryResponse data =
            args as AirtimeDataBeneficiaryResponse;
        return MaterialPageRoute(
            builder: (_) => EditBillsBeneficiaryPage(
                  item: data,
                ));
      case Routes.changePinRoute:
        return MaterialPageRoute(builder: (_) => const ChangePinPage());
      case Routes.savedCardPageRoute:
        return MaterialPageRoute(builder: (_) => const SavedCardPage());
      case Routes.addNewCardPageRoute:
        return MaterialPageRoute(builder: (_) => const AddNewCardPage());
      case Routes.newCardVerificationPageRoute:
        return MaterialPageRoute(
            builder: (_) => const NewCardVerificationPage());
      case Routes.closeAccountPageRoute:
        return MaterialPageRoute(builder: (_) => const CloseAccountPage());

      case Routes.closeAccountSuccessPageRoute:
        return MaterialPageRoute(builder: (_) => const CloseAccountSuccess());
      case Routes.accountStatementPageRoute:
        return MaterialPageRoute(builder: (_) => const AccountStatementPage());
      case Routes.schedulePaymentListPageRoute:
        return MaterialPageRoute(
            builder: (_) => const SchedulePaymentListPage());
      case Routes.editSchedulePaymentRoute:
        return MaterialPageRoute(
            builder: (_) => const EditSchedulePaymentPage());
      case Routes.helpAndSupportPageRoute:
        return MaterialPageRoute(builder: (_) => const HelpPage());
      case Routes.saveInUsdPageRoute:
        return MaterialPageRoute(builder: (_) => const SaveInUsdPage());
      case Routes.depositSaveInUsdPageRoute:
        return MaterialPageRoute(builder: (_) => const DepositSaveInUsd());
      case Routes.withdrawSaveInUsdPageRoute:
        return MaterialPageRoute(builder: (_) => const WithdrawSaveInUsd());
      case Routes.transferBeneficiariesPageRoute:
        return MaterialPageRoute(builder: (_) => const TransferBeneficiaries());
      case Routes.saveInUsdConfirmationPageRoute:
        Map<String, dynamic> v = args as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => SaveInUsdConfirmationPage(map: v));

      ///Crypto Routes
      case Routes.cryptoOnboarding:
        return MaterialPageRoute(builder: (_) => const CryptoOnboarding());
      case Routes.cryptoHome:
        return MaterialPageRoute(builder: (_) => const CryptoBottomNavPage());
      case Routes.viewCryptoWalletsPage:
        return MaterialPageRoute(builder: (_) => const ViewCryptoWallet());
      case Routes.cryptoNotificationsPageRoute:
        return transitionBuilder(
            child: const CryptoNotifications(), begin: const Offset(0.5, 0));

      case Routes.cryptoNavDrawerRoute:
        return transitionBuilder(
            child: const CryptoNavDrawerMenu(), begin: const Offset(-1, 0.0));
      case Routes.manageCryptoWallet:
        return transitionBuilder(
            child: const ManageCryptoWallet(), begin: const Offset(0.5, 0));
      case Routes.backUpCryptoWallet:
        return transitionBuilder(
            child: const CryptoWalletBackupPage(), begin: const Offset(0.5, 0));
      case Routes.currencyViewPageRoute:
        TAsset v = args as TAsset;
        return transitionBuilder(
            child: ViewCurrencyPage(asset: v), begin: const Offset(0.5, 0));
      case Routes.aboutCurrencyPage:
        TAsset v = args as TAsset;
        return transitionBuilder(
            child: AboutCurrencyPage(asset: v), begin: const Offset(0.5, 0));
      case Routes.giftCardDetailsPage:
        return transitionBuilder(
            child: const GiftCardDetailsPage(), begin: const Offset(0.5, 0));
      case Routes.addAccountPageRoute:
        return transitionBuilder(
            child: const AddAccountPage(), begin: const Offset(0.5, 0));
      case Routes.giftCardSuccessPage:
        return transitionBuilder(
            child: const GiftSuccessPage(), begin: const Offset(0.5, 0));
      case Routes.receiveAssetsPage:
        return transitionBuilder(
            child: const ReceiveAssetPage(), begin: const Offset(0.5, 0));

      default:
        return MaterialPageRoute(builder: (_) => const PhoneNumberAuthPage());
    }
  }
}
