final List<ReferralModel> referralData = [
  ReferralModel(
    image: "assets/icons/bonus.png",
    referrer: "Richard B. Taylor",
    email: "richard@gmail.com. Taylor",
    date: "21 Nov, 2024",
    amount: "\$123",
  ),
  ReferralModel(
    image: "assets/icons/bonus.png",
    referrer: "Iliana D'souza",
    email: "iliana@gmail.com'souza",
    date: "18 Nov, 2024",
    amount: "\$412",
  ),
  ReferralModel(
    image: "assets/icons/bonus.png",
    referrer: "Ronald C. Castle",
    email: "ronald@gmail.com. Castle",
    date: "12 Oct, 2024",
    amount: "\$342",
  ),
  ReferralModel(
    image: "assets/icons/bonus.png",
    referrer: "Jumanji Rock",
    email: "jumanji@gmail.com",
    date: "05 Oct, 2024",
    amount: "\$455",
  ),
  ReferralModel(
    image: "assets/icons/bonus.png",
    referrer: "Christopher",
    email: "christopher@gmail.com",
    date: "21 July, 2024",
    amount: "\$220",
  ),
  ReferralModel(
    image: "assets/icons/bonus.png",
    referrer: "Helsinki Landa",
    email: "helsinki@gmail.com",
    date: "23 July, 2024",
    amount: "\$423",
  ),
  ReferralModel(
    image: "assets/icons/bonus.png",
    referrer: "Iliana D'souza",
    email: "iliana@gmail.com'souza",
    date: "18 Nov, 2024",
    amount: "\$412",
  ),
  ReferralModel(
    image: "assets/icons/bonus.png",
    referrer: "Ronald C. Castle",
    email: "ronald@gmail.com. Castle",
    date: "12 Oct, 2024",
    amount: "\$342",
  ),
  ReferralModel(
    image: "assets/icons/bonus.png",
    referrer: "Jumanji Rock",
    email: "jumanji@gmail.com",
    date: "05 Oct, 2024",
    amount: "\$455",
  ),
  ReferralModel(
    image: "assets/icons/bonus.png",
    referrer: "Christopher",
    email: "christopher@gmail.com",
    date: "21 July, 2024",
    amount: "\$220",
  ),
];

class ReferralModel {
  final String image;
  final String referrer;
  final String email;
  final String date;
  final String amount;

  ReferralModel({
    required this.image,
    required this.referrer,
    required this.email,
    required this.date,
    required this.amount,
  });
}
