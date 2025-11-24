class User {
  final String? token;
  final String? message;

  User({this.token, this.message});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      token: json['token'],
      message: json['message'],
    );
  }
}
