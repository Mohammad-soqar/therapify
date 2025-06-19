import 'package:therapify/view/screens/call/call_screen.dart';
import 'package:therapify/view/screens/wishlist/wishlist_screen.dart';
import 'package:get/get.dart';
import 'package:therapify/view/screens/appointment/appointment_history_screen.dart';
import 'package:therapify/view/screens/appointment/session_complete_screen.dart';
import 'package:therapify/view/screens/doctor/doctor_review_screen.dart';
import 'package:therapify/view/screens/appointment/appointment_countdown_screen.dart';
import 'package:therapify/view/screens/appointment/appointment_details_screen.dart';
import 'package:therapify/view/screens/appointment/appointment_booking_screen.dart';
import 'package:therapify/view/screens/appointment/appointment_list_screen.dart';
import 'package:therapify/view/screens/department/department_screen.dart';
import 'package:therapify/view/screens/transaction/transaction_screen.dart';
import 'package:therapify/view/screens/payment/payment_preview_screen.dart';
import 'package:therapify/view/screens/payment/payment_success_screen.dart';
import 'package:therapify/view/screens/doctor/doctor_list_screen.dart';
import 'package:therapify/res/routes/routes_name.dart';
import 'package:therapify/view/screens/2fa/two_fa_screen.dart';
import 'package:therapify/view/screens/auth/signin_screen.dart';
import 'package:therapify/view/screens/auth/signup_screen.dart';
import 'package:therapify/view/screens/home/home_screen.dart';
import 'package:therapify/view/screens/kyc/kyc_submission_screen.dart';
import 'package:therapify/view/screens/kyc/kyc_verification_screen.dart';
import 'package:therapify/view/screens/notification/notification_permission_screen.dart';
import 'package:therapify/view/screens/notification/notification_screen.dart';
import 'package:therapify/view/screens/onboard/onboarding_screen.dart';
import 'package:therapify/view/screens/payment/payment_screen.dart';
import 'package:therapify/view/screens/profile/change_password_screen.dart';
import 'package:therapify/view/screens/profile/edit_profile_screen.dart';
import 'package:therapify/view/screens/profile/profile_screen.dart';
import 'package:therapify/view/screens/doctor/doctor_details_screen.dart';
import 'package:therapify/view/screens/splash/splash_screen.dart';
import 'package:therapify/view/screens/support_ticket/chat_screen.dart';
import 'package:therapify/view/screens/support_ticket/create_ticket_screen.dart';
import 'package:therapify/view/screens/support_ticket/ticket_screen.dart';
import 'package:therapify/view/widgets/bottom_nav.dart';

class AppRoutes {
  static appRoutes() {
    return [
      GetPage(
        name: RoutesName.splashScreen,
        page: () => const SplashScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      GetPage(
        name: RoutesName.onboardingScreen,
        page: () => const OnboardingScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      GetPage(
        name: RoutesName.signInScreen,
        page: () => const SignInScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      GetPage(
        name: RoutesName.signUpScreen,
        page: () => const SignUpScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      GetPage(
        name: RoutesName.homeScreen,
        page: () => const HomeScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      GetPage(
        name: RoutesName.bottomNavScreen,
        page: () => const BottomNavbar(),
        transition: Transition.rightToLeftWithFade,
      ),
      GetPage(
        name: RoutesName.departmentScreen,
        page: () => const DepartmentScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      GetPage(
        name: RoutesName.appointmentListScreen,
        page: () => const AppointmentListScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      GetPage(
        name: RoutesName.chatScreen,
        page: () => const ChatScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      GetPage(
        name: RoutesName.profileScreen,
        page: () => const ProfileScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      GetPage(
        name: RoutesName.editProfileScreen,
        page: () => const EditProfileScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      GetPage(
        name: RoutesName.doctorDetailsScreen,
        page: () => const DoctorDetailsScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      GetPage(
        name: RoutesName.doctorReviewScreen,
        page: () => const DoctorReviewScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      GetPage(
        name: RoutesName.appointmentBookingScreen,
        page: () => const AppointmentBookingScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      GetPage(
        name: RoutesName.appointmentDetailsScreen,
        page: () => const AppointmentDetailsScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      GetPage(
        name: RoutesName.appointmentHistoryScreen,
        page: () => const AppointmentHistoryScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      GetPage(
        name: RoutesName.paymentPreviewScreen,
        page: () => const PaymentPreviewScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      GetPage(
        name: RoutesName.appointmentCountdownScreen,
        page: () => const AppointmentCountdownScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      GetPage(
        name: RoutesName.paymentScreen,
        page: () => const PaymentScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      GetPage(
        name: RoutesName.paymentSuccessScreen,
        page: () => const PaymentSuccessScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      GetPage(
        name: RoutesName.changePasswordScreen,
        page: () => const ChangePasswordScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      GetPage(
        name: RoutesName.ticketScreen,
        page: () => const TicketScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      GetPage(
        name: RoutesName.createTicketScreen,
        page: () => const CreateTicketScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      GetPage(
        name: RoutesName.twoFaScreen,
        page: () => const TwoFactorScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      GetPage(
        name: RoutesName.kycVerificationScreen,
        page: () => const KycVerificationScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      GetPage(
        name: RoutesName.kycSubmissionScreen,
        page: () => const KycSubmissionScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      GetPage(
        name: RoutesName.notificationScreen,
        page: () => const NotificationScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      GetPage(
        name: RoutesName.notificationPermissionScreen,
        page: () => const NotificationPermissionScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      GetPage(
        name: RoutesName.doctorListScreen,
        page: () => const DoctorListScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      GetPage(
        name: RoutesName.sessionCompleteScreen,
        page: () => const SessionCompleteScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      GetPage(
        name: RoutesName.transactionScreen,
        page: () => const TransactionScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      GetPage(
        name: RoutesName.wishlistScreen,
        page: () => const WishlistScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      GetPage(
        name: RoutesName.callScreen,
        page: () => const CallScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
    ];
  }
}
