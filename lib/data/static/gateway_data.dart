final List<GatewayModel> gatewayData = [
  GatewayModel(
    image: "assets/icons/google_pay.png",
    title: "Google Pay",
    description: "This amount will arrived Instantly",
  ),
  GatewayModel(
    image: "assets/icons/apple_pay.png",
    title: "Apple Pay",
    description: "This amount will arrived Instantly",
  ),
  GatewayModel(
    image: "assets/icons/visacard.png",
    title: "Visa",
    description: "This amount will arrived Instantly",
  ),
  GatewayModel(
    image: "assets/icons/mastercard.png",
    title: "Mastercard",
    description: "This amount will arrived Instantly",
  ),
  GatewayModel(
    image: "assets/icons/amex.png",
    title: "Amex Card",
    description: "This amount will arrived Instantly",
  ),
  GatewayModel(
    image: "assets/icons/paypal.png",
    title: "Paypal",
    description: "This amount will arrived Instantly",
  ),
];

class GatewayModel {
  final String image;
  final String title;
  final String description;

  GatewayModel({
    required this.image,
    required this.title,
    required this.description,
  });
}
