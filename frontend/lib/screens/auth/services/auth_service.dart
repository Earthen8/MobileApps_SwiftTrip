import 'package:swifttrip_frontend/repositories/auth_repository.dart';
import '../models/auth_models.dart';

class AuthService {
  final AuthRepository _repository = AuthRepository();

  Future<bool> login(LoginRequest request) async {
    return await _repository.login(request.email, request.password);
  }

  Future<bool> signup(SignupRequest request) async {
    return await _repository.signup(
      request.email,
      request.password,
      request.confirmPassword,
    );
  }

  Future<void> requestOtp(String email, {bool isPasswordReset = false}) async {
    await _repository.requestOtp(email, isPasswordReset: isPasswordReset);
  }

  Future<void> verifyOtp(String email, String otp) async {
    await _repository.verifyOtp(email, otp);
  }

  Future<void> updatePassword(String email, String password) async {
    await _repository.updatePassword(email, password);
  }

  Future<void> updateUserProfile(UserProfile profile) async {
    await _repository.updateUserProfile(profile.toJson());
  }
}
