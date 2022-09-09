
abstract class Repository{
  Future<void> inscriptionBoutique(String id, String nom, String mail, String adresse, String cp, String ville, String mdp);
  Future<void> inscriptionUtilisateur(String id, String nom, String mail, String mdp);
  Future<String?> connexionBoutique(String id, String mdp);
  Future<String> verifId(String id);
}