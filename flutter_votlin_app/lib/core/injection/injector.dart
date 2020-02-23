import 'package:flutter_votlin_app/core/config/config.dart';
import 'package:flutter_votlin_app/core/data/database/sqlite_helper.dart';
import 'package:flutter_votlin_app/core/data/network/core_http_client.dart';
import 'package:flutter_votlin_app/core/data/network/dart_http_client.dart';
import 'package:flutter_votlin_app/features/talks/datasource/database/talks_db_datasource.dart';
import 'package:flutter_votlin_app/features/talks/datasource/database/talks_mock_db_datasource.dart';
import 'package:flutter_votlin_app/features/talks/datasource/mock/talks_mock_datasource.dart';
import 'package:flutter_votlin_app/features/talks/datasource/network/talks_network_datasource.dart';
import 'package:flutter_votlin_app/features/talks/datasource/talks_datasources.dart';
import 'package:flutter_votlin_app/features/talks/datasource/talks_repository_impl.dart';
import 'package:flutter_votlin_app/features/talks/repositories.dart';
import 'package:get_it/get_it.dart';

class Injector {
  static final Injector _singleton = new Injector._internal();
  GetIt _getIt;

  factory Injector() {
    return _singleton;
  }

  Injector._internal() {
    _getIt = new GetIt();
  }

  static init() {
    _singleton._getIt.registerSingleton(_singleton._createSqliteHelper());
    _singleton._getIt.registerSingleton(_singleton._createTalksRepository());
  }

  SqliteHelper _createSqliteHelper() {
    return SqliteHelper();
  }

  TalksRepository _createTalksRepository() {
    TalksRemoteDataSource talksRemoteDataSource;
    if ((Config.flavor == Flavor.LOCALHOST_EMULATOR) ||
        (Config.flavor == Flavor.MOCK_WEBSERVER)) {
      CoreHttpClient coreHttpClient = DartHttpClient();
      talksRemoteDataSource = TalksNetworkDataSource(coreHttpClient);
    } else if (Config.flavor == Flavor.MOCK) {
      talksRemoteDataSource = TalksMockDataSource();
    }

    TalksLocalDataSource talksLocalDataSource;
    if (Config.flavor == Flavor.MOCK_WEBSERVER) {
      talksLocalDataSource = TalksMockDbDataSource();
    } else {
      talksLocalDataSource = TalksDbDataSource(dbHelper);
    }

    return TalksRepositoryImpl(
      talksRemoteDataSource,
      talksLocalDataSource,
    );
  }

  static SqliteHelper get dbHelper => _singleton._getIt<SqliteHelper>();

  static TalksRepository get talksRepository =>
      _singleton._getIt<TalksRepository>();
}
