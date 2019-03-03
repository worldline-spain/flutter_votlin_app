# Data module

Data layer.
Actually, this module only has dart dependencies.

This module contains:
- Implementation of repositories defined in domain layer (talks repository)
- Implementation of different datasources. Actually we are using:
    - Network (implements a remote datasource)
    - Mock (implements a remote datasource because it is a mock for network datasource)
    - Database (implements a local datasource, for save the talks rating)

## Network
Actually, the implementation of http client is done with [package http from dart](https://pub.dartlang.org/packages/http)

There is a wrapper to make it easier [here](lib/core/network)

Interesting points:
- Endpoints are defined [here](lib/talks/api) (inspired by similar idea used in [voxxed app](https://github.com/devoxx/voxxedapp/blob/master/lib/data/web_client.dart))
- Implementation of datasource and network models are [here](lib/talks/datasource/network)
- Network models depends on json serializable. [Here](https://flutter.io/docs/development/data-and-backend/json) more info.
  Actually, this is a bit annoying because json serializable depends on code generation.

  Every time you modify a network model, you need to go to 'data' folder in the project, and run the following command:
  ```
  flutter packages pub run build_runner build
  ```
  After executing this, a file with extension .g.dart will be generated, for each file you have defined the code generation.

## Mock
A mock used when you are lazy and you don't want start a json server.

Interesting points:
- Mock datasource is located [here](lib/talks/datasource/mock)
- The implementation of mock datasource is a local json file.
- To be able to read json file, actually we are using json literal annotation. More info [here](https://flutter-academy.com/work-with-json-in-flutter-part-2-json-serializable/)
- Actually, there is fake delay of 500 milliseconds (hardcoded) to simulate a network call
- If you modify schedule.json, don't forget to execute the command `flutter packages pub run build_runner build`

## Database
Actually, database is only used for save the talk ratings.
A nice experiment to evaluate the package [sqflite](https://pub.dartlang.org/packages/sqflite), a wrapper over sqlite.

Interesting points:
- To make it easier, there is a SqliteHelper [here](lib/core/database/sqlite_helper.dart)
- Sqlite tables are defined [here](lib/core/database/sqlite_tables.dart)
- Implementation of datasource is [here](lib/talks/datasource/database)

## Mappers
To avoid use network models or database models directly in domain layer, we need to define mappers to transform network models
or database models into domain models. Mappers are boring...

You can define methods 'toModel' in your models, (for instance, in network models), or you can
implement the mappers in a separate class (for instance, for database, we have a separate class).