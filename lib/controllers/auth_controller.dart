import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../services/api_service.dart';
import '../views/home/home_view.dart';
import '../views/auth/login_view.dart';

class AuthController extends GetxController {
  final ApiService _apiService = ApiService();
  var isLoading = false.obs;

  Future<void> login(String phone, String password) async {
    isLoading.value = true;
    try {
      await _apiService.login(phone, password);
      Get.offAll(() => HomeView());
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> logout() async {
    final box = GetStorage();
    await box.erase();
    Get.offAll(() => LoginView());
  }
}
