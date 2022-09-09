import 'package:mysql1/mysql1.dart';

class Mysql {

  static String host = '10.0.2.2',
      user = 'root',
      password = 'root',
      db = 'ygotournaments';

  static int port = 3306;

  Mysql();

  Future<MySqlConnection> getConnection() async {
    var settings = ConnectionSettings(
        host: host,
        port: port,
        user: user,
        password: password,
        db: db
    );
    return await MySqlConnection.connect(settings);
  }
}