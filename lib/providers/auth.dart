import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '/models/user_model.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _userId;
  UserModel? _user;

  bool get isAuth {
    return _token != null;
  }

  String? get userId => _userId;

  UserModel? get user => _user;

  Future<void> signin(String email, String password) async {
    final body = json.encode({'email': email, 'password': password});
    final url = Uri.https(
      'kids-zone-backend-v2.onrender.com',
      '/api/v1/user/login',
    );

    try {
      final res = await http.post(url,
          body: body,
          headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      final extractedData = json.decode(res.body);

      if (res.statusCode == 200) {
        _token = extractedData['token'];
        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', extractedData['token']);
      } else {
        if (extractedData['error'] != null) {
          throw HttpException(extractedData['error']);
        } else {
          throw const HttpException(
              'some thing went wrong please try agin later');
        }
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signup(
      String email, String firstName, String lastName, String password) async {
    final body = json.encode({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password
    });
    final url = Uri.https(
      'kids-zone-backend-v2.onrender.com',
      '/api/v1/user/register',
    );

    try {
      final res = await http.post(url,
          body: body,
          headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      final extractedData = json.decode(res.body);

      if (res.statusCode == 201) {
        _token = extractedData['token'];

        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', extractedData['token']);

        notifyListeners();
      } else {
        if (extractedData['error'] != null) {
          throw HttpException(extractedData['error']);
        } else {
          throw const HttpException(
              'some thing went wrong please try agin later');
        }
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final url = Uri.https(
      'kids-zone-backend-v2.onrender.com',
      '/api/v1/user/me',
    );

    final token = prefs.getString('token');
    if (token != null) {
      try {
        final res = await http.get(url,
            headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
        final extractedData = json.decode(res.body);
        if (res.statusCode == 200) {
          print(token);
          _token = token;
          _userId = extractedData['data']['_id'];
          _user = UserModel(
            firstName: extractedData['data']['firstName'],
            lastName: extractedData['data']['lastName'],
            email: extractedData['data']['email'],
            createdAt: DateTime.parse(
              extractedData['data']['createdAt'],
            ),
          );
          notifyListeners();
        }
      } catch (error) {
        rethrow;
      }
    } else {
      return;
    }
  }

  Future<void> changeDetails(
      String email, String firstName, String lastName) async {
    final body = json.encode({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    });
    final prefs = await SharedPreferences.getInstance();
    final url = Uri.https(
      'kids-zone-backend-v2.onrender.com',
      '/api/v1/user/update-user',
    );

    final token = prefs.getString('token');
    if (token != null) {
      try {
        final res = await http.post(url,
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
              HttpHeaders.contentTypeHeader: 'application/json'
            },
            body: body);
        final extractedData = json.decode(res.body);
        if (res.statusCode == 200) {
          _user = UserModel(
            firstName: extractedData['data']['firstName'],
            lastName: extractedData['data']['lastName'],
            email: extractedData['data']['email'],
            createdAt: DateTime.parse(
              extractedData['data']['createdAt'],
            ),
          );
          notifyListeners();
        } else {
          throw HttpException(extractedData['error']);
        }
      } catch (error) {
        rethrow;
      }
    } else {
      return;
    }
  }

  Future<void> changePassword(
      String currentPassword, String newPassword) async {
    final body = json.encode({
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    });
    final prefs = await SharedPreferences.getInstance();
    final url = Uri.https(
      'kids-zone-backend-v2.onrender.com',
      '/api/v1/user/update-password',
    );

    final token = prefs.getString('token');
    if (token != null) {
      try {
        final res = await http.post(url,
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
              HttpHeaders.contentTypeHeader: 'application/json'
            },
            body: body);
        final extractedData = json.decode(res.body);
        if (res.statusCode == 200) {
          notifyListeners();
        } else {
          throw HttpException(extractedData['error']);
        }
      } catch (error) {
        rethrow;
      }
    } else {
      return;
    }
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _user = null;

    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
