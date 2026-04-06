import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../core/constants.dart';
import '../../repositories/auth_repository.dart';
import 'models/checkout_details_model.dart';

class CheckoutController extends ChangeNotifier {
  CheckoutDetailsModel? _details;
  bool _isLoading = false;
  String? _lastErrorMessage;

  // Payment Form Controllers
  final cardNumberController = TextEditingController();
  final expiryDateController = TextEditingController();
  final cvcController = TextEditingController();

  CheckoutDetailsModel? get details => _details;
  bool get isLoading => _isLoading;
  String? get lastErrorMessage => _lastErrorMessage;

  void init(CheckoutDetailsModel details) {
    _details = details;
    notifyListeners();
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvcController.dispose();
    super.dispose();
  }

  Future<bool> confirmPurchase() async {
    _lastErrorMessage = null;
    final cleanCardNumber = cardNumberController.text.replaceAll(' ', '');
    final cvc = cvcController.text;

    if (cleanCardNumber.length != 16 ||
        expiryDateController.text.length != 5 ||
        cvc.length != 3) {
      _lastErrorMessage = 'Please fill in all payment details';
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final dio = Dio();
      final token = await AuthRepository().getToken();
      
      final response = await dio.post(
        '${Constants.bookingsUrl}checkout/confirm/',
        options: Options(headers: {
          if (token != null) 'Authorization': 'Bearer $token',
        }),
      );

      _isLoading = false;
      notifyListeners();

      if (response.statusCode == 200) {
        return true;
      }
      _lastErrorMessage = 'Server error. Please try again.';
      return false;
    } on DioException catch (e) {
      debugPrint('Error confirming purchase: $e');
      _lastErrorMessage = (e.response?.statusCode == 401)
          ? 'Session expired. Please log in again.'
          : 'Failed to confirm purchase. Try again later.';
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      debugPrint('Error confirming purchase: $e');
      _lastErrorMessage = 'An error occurred. Please try again.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
