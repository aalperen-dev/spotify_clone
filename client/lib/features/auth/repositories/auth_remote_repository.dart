import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:spotify/core/constants/server_constants.dart';
import 'package:spotify/core/failure/app_failure.dart';
import 'package:spotify/features/auth/model/user_model.dart';

class AuthRemoteRepository {
  Future<Either<AppFailureMsg, UserModel>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
          '${ServerConstants.serverUrl}/auth/signup',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 201) {
        // error handling
        return Left(AppFailureMsg(resBodyMap['details']));
      }

      // return Right(UserModel.fromJson(response.body));
      return Right(UserModel.fromMap(resBodyMap));
    } catch (e) {
      return Left(AppFailureMsg(e.toString()));
    }
  }

  Future<Either<AppFailureMsg, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
          '${ServerConstants.serverUrl}/auth/login',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 200) {
        return Left(AppFailureMsg(resBodyMap['detail']));
      }
      return Right(UserModel.fromMap(resBodyMap));
    } catch (e) {
      return Left(AppFailureMsg(e.toString()));
    }
  }
}
