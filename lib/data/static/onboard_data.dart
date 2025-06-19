final List<Onboard> onboardData = [
  Onboard(
    image: "assets/images/onboarding_1.png",
    title: "Discover the Most Exemplary Doctors in Your Area",
    subTitle:
        "Dynamically empower pandemic scenarios rather than wireless deliverables redefine ethical data before seamless web services.",
  ),
  Onboard(
    image: "assets/images/onboarding_2.png",
    title: "Which of these would you like to have consulted?",
    subTitle:
        "Dynamically empower pandemic scenarios rather than wireless deliverables redefine ethical data before seamless web services.",
  ),
  Onboard(
    image: "assets/images/onboarding_3.png",
    title: "A doctor-patient video talk about several health issues",
    subTitle:
        "Dynamically empower pandemic scenarios rather than wireless deliverables redefine ethical data before seamless web services.",
  ),
];

class Onboard {
  final String image;
  final String title;
  final String subTitle;

  Onboard({
    required this.image,
    required this.title,
    required this.subTitle,
  });
}
