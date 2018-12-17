import 'package:data/core/config/config.dart';
import 'package:data/core/network/core_http_client.dart';
import 'package:data/core/network/dart_http_client.dart';
import 'package:data/core/database/sqlite_helper.dart';
import 'package:data/talks/datasource/database/talks_db_datasource.dart';
import 'package:data/talks/datasource/mock/talks_mock_datasource.dart';
import 'package:data/talks/datasource/network/talks_network_datasource.dart';
import 'package:data/talks/datasource/talks_datasources.dart';
import 'package:data/talks/talks_repository_impl.dart';
import 'package:domain/repository/talks_repository.dart';
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
    if (Config.flavor == Flavor.LOCALHOST_EMULATOR) {
      CoreHttpClient coreHttpClient = DartHttpClient();
      talksRemoteDataSource = TalksNetworkDataSource(coreHttpClient);
    } else if (Config.flavor == Flavor.MOCK) {
      talksRemoteDataSource = TalksMockDataSource();
    }

    return TalksRepositoryImpl(
      talksRemoteDataSource,
      TalksDbDataSource(dbHelper),
    );
  }

  static SqliteHelper get dbHelper => _singleton._getIt<SqliteHelper>();

  static TalksRepository get talksRepository =>
      _singleton._getIt<TalksRepository>();
}
