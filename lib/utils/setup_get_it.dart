import 'package:get_it/get_it.dart';
import 'package:github_app/services/api_config.dart';
import 'package:github_app/services/github_api.dart';

void setup() {
  GetIt.I.registerSingleton<GithubApi>(GithubApi(ApiConfig.createInstance()));
}
