final List<NotificationModel> notificationData = [
  NotificationModel(
    image: "assets/icons/notification_1.png",
    title: "Payment Successful",
    message: "Appointment Confirmed Dr. Gulian Alvarez Call will be held at 12.30 AM",
    time: "29 mins ago",
  ),
  NotificationModel(
    image: "assets/icons/notification_2.png",
    title: "New Categories Services",
    message: "Your appointment will be start after 15 minutes. Stay with us.",
    time: "2 hours ago",
  ),
  NotificationModel(
    image: "assets/icons/notification_3.png",
    title: "Today’s Special Offers",
    message: "These days, finding our specialist doctor and appointment is simple.",
    time: "5 hours ago",
  ),
  NotificationModel(
    image: "assets/icons/notification_4.png",
    title: "Credit Card Connected!",
    message: "Appointment Confirmed Dr. Gulian Alvarez Call will be held at 12.30 AM",
    time: "1 day ago",
  ),
  NotificationModel(
    image: "assets/icons/notification_5.png",
    title: "Account Setup Successful!",
    message: "Your account has been credited!",
    time: "1 day ago",
  ),
  NotificationModel(
    image: "assets/icons/notification_6.png",
    title: "Active Function process!",
    message: "Your appointment will be start after 15 minutes. Stay with us.",
    time: "2 days ago",
  ),
  NotificationModel(
    image: "assets/icons/notification_4.png",
    title: "Credit Card Connected!",
    message: "Appointment Confirmed Dr. Gulian Alvarez Call will be held at 12.30 AM",
    time: "2 days ago",
  ),
  NotificationModel(
    image: "assets/icons/notification_5.png",
    title: "Account Setup Successful!",
    message: "Your account has been credited!",
    time: "2 days ago",
  ),
  NotificationModel(
    image: "assets/icons/notification_6.png",
    title: "Active Function process!",
    message: "Your appointment will be start after 15 minutes. Stay with us.",
    time: "4 days ago",
  ),
];

class NotificationModel {
  final String image;
  final String title;
  final String message;
  final String time;

  NotificationModel({
    required this.image,
    required this.title,
    required this.message,
    required this.time,
  });
}
