import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  Map<String, dynamic> _userData = {};

  bool get isAuthenticated => _isAuthenticated;
  Map<String, dynamic> get userData => _userData;

  // Inisialisasi Dio
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://10.10.24.6:8080/login',
    connectTimeout: 5000,
    receiveTimeout: 3000,
    headers: {
      "Content-Type": "application/json"
    },
  ));

  Future<void> login(String username, String password) async {
    try {
      // Mengirim permintaan POST ke server dengan data JSON
      final response = await _dio.post(
        '/login',
        data: jsonEncode({
          "username": username,
          "password": password,
        }),
      );

      // Memeriksa status kode HTTP
      if (response.statusCode == 200) {
        final data = response.data;

        // Mengecek status respons
        if (data['status'] == 'success') {
          _isAuthenticated = true;
          _userData = data['data']; // Menyimpan data pengguna untuk diakses di UI
          notifyListeners();
        } else {
          _isAuthenticated = false;
          throw Exception(data['message'] ?? 'Login failed');
        }
      } else {
        throw Exception('Failed to connect to server');
      }
    } catch (error) {
      print("Error: $error");
      _isAuthenticated = false;
      throw error; // Lempar error agar bisa ditangani di UI
    }
  }
}
