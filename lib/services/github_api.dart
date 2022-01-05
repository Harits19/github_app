import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:github_app/models/api_response.dart';
import 'package:github_app/models/issue.dart';
import 'package:github_app/models/repository.dart';
import 'package:github_app/models/user.dart';
import 'package:github_app/services/api_config.dart';

class GithubApi {
  GithubApi(this._dio);

  late final Dio _dio;

  getSearchUser({
    required ValueChanged<List<User>> onSuccess,
    required ValueChanged<String> onError,
    required String query,
    required int page,
  }) async {
    try {
      final response = await _dio.get(
        "/users",
        queryParameters: ApiConfig.toParameter(query, page),
      );
      final result = ApiResponse.fromJson(response.data);
      final listUser = result.items
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList();
      onSuccess(listUser ?? []);
    } on DioError catch (e) {
      onError(e.message);
    } on Exception catch (e) {
      onError(e.toString());
    }
  }

  getSearchIssue({
    required ValueChanged<List<Issue>> onSuccess,
    required ValueChanged<String> onError,
    required String query,
    required int page,
  }) async {
    try {
      final response = await _dio.get(
        "/issues",
        queryParameters: ApiConfig.toParameter(query, page),
      );
      final result = ApiResponse.fromJson(response.data);
      final listUser = result.items
          ?.map((e) => Issue.fromJson(e as Map<String, dynamic>))
          .toList();
      onSuccess(listUser ?? []);
    } on DioError catch (e) {
      onError(e.message);
    } on Exception catch (e) {
      onError(e.toString());
    }
  }

  getSearchRepository({
    required ValueChanged<List<Repository>> onSuccess,
    required ValueChanged<String> onError,
    required String query,
    required int page,
  }) async {
    try {
      final response = await _dio.get(
        "/repositories",
        queryParameters: ApiConfig.toParameter(query, page),
      );
      final result = ApiResponse.fromJson(response.data);
      final listRepo = result.items
          ?.map((e) => Repository.fromJson(e as Map<String, dynamic>))
          .toList();
      onSuccess(listRepo ?? []);
    } on DioError catch (e) {
      onError(e.message);
    } on Exception catch (e) {
      onError(e.toString());
    }
  }
}
