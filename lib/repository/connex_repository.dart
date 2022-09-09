import '../bdd/bdd.dart';
import '../repository/repository.dart';
import 'package:mysql1/mysql1.dart';

class ConnexRepository implements Repository{

  @override
  Future<void> inscriptionBoutique(String id, String nom, String mail, String adresse, String cp, String ville, String mdp) async {
    final db = Mysql();
    await db.getConnection().then(
      (conn) async {
        await conn.query(
          'Insert into ygotournaments.boutique values(?, ?, ?, ?, ?, ?, sha2(?, 512))',
          [id, nom, mail, adresse, cp, ville, mdp]);
        await conn.close();
      },
    );
  }

  @override
  Future<void> inscriptionUtilisateur(String id, String nom, String mail, String mdp) async {
    final db = Mysql();
    await db.getConnection().then(
      (conn) async {
        await conn.query(
          'Insert into ygotournaments.utilisateur values(?, ?, ?, sha2(?, 512))',
          [id, nom, mail, mdp]);
        await conn.close();
      },
    );
  }
  @override
  Future<String?> connexionBoutique(String id, String mdp) async {
    final db = Mysql();
    String? result;
    await db.getConnection().then(
      (conn) async {
        await conn.query(
          'SELECT COUNT(id_boutique) as count '
          'FROM boutique '
          'WHERE id_boutique = ? '
          'AND mdp_boutique = sha2(?,512) ',
          [id, mdp]).then((results) {
          for (var res in results) {
            result = res["count"].toString();
          }
          return result;
        }).onError((error, stackTrace) {
          print(error);
        });
        await conn.close();
      },
    );
  }

  @override
  Future<String> verifId(String id) async {
    final db = Mysql();
    String text = "error";
    await db.getConnection().then(
        (conn) async {
          await conn.query(
            'SELECT COUNT(id_konami_utilisateur) as count '
            'FROM utilisateur '
            'WHERE id_konami_utilisateur = ?',
            [id]
          ).then((results) {
            for (var res in results) {
              text = res["count"].toString();
            }
          }).onError((error, stackTrace) {
            print(error);
          });
        conn.close();
        });
    return text;
  }
}