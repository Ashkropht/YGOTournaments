import 'package:flutter/material.dart';
import '../repository/connex_repository.dart';
import '../controller/connex_controller.dart';

class InscPage extends StatefulWidget {
  const InscPage({Key? key, required this.switched}) : super(key: key);
  final bool switched;

  @override
  State<InscPage> createState() => _InscPageState();
}

class _InscPageState extends State<InscPage> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _nomController = TextEditingController();
  final _mailController = TextEditingController();
  final _adresseController = TextEditingController();
  final _cpController = TextEditingController();
  final _villeController = TextEditingController();
  final _mdpController = TextEditingController();
  final _mdpConfController = TextEditingController();
  String cpt = "0";

  @override
  Widget build(BuildContext context) {
    var connexController = ConnexController(ConnexRepository());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inscription"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                widget.switched ? boutiqueForm(connexController) : utilisateurForm(connexController),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: widget.switched ? Colors.brown : Colors.orange,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.switched ?
                            connexController.inscriptionBoutique(
                              _idController.text.toString(),
                              _nomController.text.toString(),
                              _mailController.text.toString(),
                              _adresseController.text.toString(),
                              _cpController.text.toString(),
                              _villeController.text.toString(),
                              _mdpController.text.toString()
                            ):
                            connexController.inscriptionUtilisateur(
                              _idController.text.toString(),
                              _nomController.text.toString(),
                              _mailController.text.toString(),
                              _mdpController.text.toString()
                            );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("Inscription")
                    )
                  ]
                )
              ]
            ),
          ],
        )
      ),
    );
  }

  boutiqueForm(connex) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          createTextField("Identifiant", _idController),
          createTextField("Nom", _nomController),
          createTextField("Mail", _mailController),
          createTextField("Adresse", _adresseController),
          createTextField("Code postal", _cpController),
          createTextField("Ville", _villeController),
          createTextField("Mot de passe", _mdpController),
          createTextField("Confirmation mot de passe", _mdpConfController, mdpConf : true, controller2 : _mdpController),
        ]
      )
    );
  }

  utilisateurForm(connex) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          createTextField("Code Konami", _idController, verif : "id", connex: connex),
          createTextField("Pseudonyme Konami", _nomController),
          createTextField("Mail", _mailController),
          createTextField("Mot de passe", _mdpController),
          createTextField("Confirmation mot de passe", _mdpConfController, mdpConf : true, controller2 : _mdpController),
        ]
      )
    );
  }

  createTextField(String text, controller, {mdpConf = false, controller2, verif = "non", connex}) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
            child: TextFormField(
                controller: controller,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: text,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  )
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez remplir ce champs";
                  }
                  if (mdpConf && value != controller2.text.toString()) {
                    return "Mots de passe différents";
                  }
                  /*if (verif == "id") {
                    getResult(connex, value);
                    if (cpt == "1") {
                      return "cet ID est déjà utilisé";
                    }
                    //print("final : " + cpt);
                  }*/

                  if (verif == "mail") {

                  }
                  return null;
                }
            )
          ),
        ),
      ]
    );
  }

  /*Future<String?> getResult(connex, value) async {
    String temp = await connex.verifId(value);
    setState(() {
      cpt = temp;
    });
    print("getResult : " + cpt);
  }*/
}

//kellr 0324578406