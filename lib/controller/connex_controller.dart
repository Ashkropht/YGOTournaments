import '../repository/repository.dart';

class ConnexController{
  final Repository _repository;
  ConnexController(this._repository);

  Future<void> inscriptionBoutique(String id, String nom, String mail, String adresse, String cp, String ville, String mdp) async{
    return _repository.inscriptionBoutique(id, nom, mail, adresse, cp, ville, mdp);
  }

  Future<void> inscriptionUtilisateur(String id, String nom, String mail, String mdp) async{
    return _repository.inscriptionUtilisateur(id, nom, mail, mdp);
  }

  Future<String?> connexionBoutique(String id, String mdp) async{
    return _repository.connexionBoutique(id, mdp);
  }

  Future<String> verifId(String id) async {
    return await _repository.verifId(id);
  }
}