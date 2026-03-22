class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}

class SignupRequest {
  final String email;
  final String password;
  final String confirmPassword;

  SignupRequest({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'confirm_password': confirmPassword,
      };
}

class UserProfile {
  final String firstName;
  final String lastName;
  final String dateOfBirth;

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        firstName: json['first_name'] ?? '',
        lastName: json['last_name'] ?? '',
        dateOfBirth: json['date_of_birth'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'date_of_birth': dateOfBirth,
      };
}
