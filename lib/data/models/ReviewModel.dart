class ReviewModel {
  final String userId;
  final String doctorId;
  final String date;
  final int rating;
  final String description;

  ReviewModel({
    required this.userId,
    required this.doctorId,
    required this.date,
    required this.rating,
    required this.description,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      userId: json['userId'],
      doctorId: json['doctorId'],
      date: json['date'],
      rating: json['rating'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'doctorId': doctorId,
    'date': date,
    'rating': rating,
    'description': description,
  };
}
