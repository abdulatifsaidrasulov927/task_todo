class UserModel {
  final int pk;
  final String username;
  final String email;
  final String firstName;
  final String lastName;

  UserModel({
    required this.pk,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      pk: json['pk'],
      username: json['username'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }
}
