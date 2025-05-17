class Jwt {
  final String token;

  Jwt({required this.token});

  factory Jwt.fromJson(Map<String, dynamic> json) {
    return Jwt(token: json['token'] as String);
  }

  Jwt copyWith({String? token}) {
    return Jwt(
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
    };
  }
}
