final List<TransactionModel> transactionData = [
  TransactionModel(
    image: "assets/icons/send.png",
    title: "Invest from wallet",
    email: "richard@gmail.com",
    date: "21 Nov, 2024",
    amount: "\$123",
  ),
  TransactionModel(
    image: "assets/icons/received.png",
    title: "Deposit via Stripe",
    email: "iliana@gmail.com",
    date: "18 Nov, 2024",
    amount: "\$412",
  ),
  TransactionModel(
    image: "assets/icons/send.png",
    title: "Deposit via Stripe",
    email: "ronald@gmail.com",
    date: "12 Oct, 2024",
    amount: "\$342",
  ),
  TransactionModel(
    image: "assets/icons/received.png",
    title: "Payout via binance",
    email: "jumanji@gmail.com",
    date: "05 Oct, 2024",
    amount: "\$455",
  ),
  TransactionModel(
    image: "assets/icons/send.png",
    title: "Invest from wallet",
    email: "christopher@gmail.com",
    date: "21 July, 2024",
    amount: "\$220",
  ),
  TransactionModel(
    image: "assets/icons/received.png",
    title: "Invest from wallet",
    email: "helsinki@gmail.com",
    date: "23 July, 2024",
    amount: "\$423",
  ),
  TransactionModel(
    image: "assets/icons/send.png",
    title: "Payout via binance",
    email: "iliana@gmail.com",
    date: "18 Nov, 2024",
    amount: "\$412",
  ),
  TransactionModel(
    image: "assets/icons/send.png",
    title: "Payout via binance",
    email: "ronald@gmail.com",
    date: "12 Oct, 2024",
    amount: "\$342",
  ),
  TransactionModel(
    image: "assets/icons/received.png",
    title: "Deposited via bank transfer",
    email: "jumanji@gmail.com",
    date: "05 Oct, 2024",
    amount: "\$455",
  ),
  TransactionModel(
    image: "assets/icons/send.png",
    title: "Deposit via Stripe",
    email: "christopher@gmail.com",
    date: "21 July, 2024",
    amount: "\$220",
  ),
];

class TransactionModel {
  final String image;
  final String title;
  final String email;
  final String date;
  final String amount;

  TransactionModel({
    required this.image,
    required this.title,
    required this.email,
    required this.date,
    required this.amount,
  });
}
