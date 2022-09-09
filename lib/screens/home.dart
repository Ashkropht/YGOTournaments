import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'inscription.dart';
import '../repository/connex_repository.dart';
import '../controller/connex_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool switched = true;
  String connected = "no";
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _mdpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var connexController = ConnexController(ConnexRepository());
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: connected == "no" ? pageConnexion(connexController) : pageAccueil()
      )//connected ? pageAccueil() : pageConnexion(connexController)
    );
  }

  Widget pageAccueil() {
    return Column(
        children: [
          Row(
            children: [
              const Text(
                "Bonjour"
              )
            ]
          )
        ]
    );
  }
  
  Widget pageConnexion(connex) {
    return Column(
          children: [
            Column(
                children: [
                  Row(
                      children: [
                        Expanded(
                            flex:1,
                            child: Text(
                                "Joueur",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: !switched ? Colors.orange : Colors.grey
                                )
                            )
                        ),
                        Expanded(
                            flex:1,
                            child: Switch(
                                value: switched,
                                inactiveThumbColor: Colors.orange,
                                inactiveTrackColor: Colors.orange[100],
                                onChanged: (bool) {
                                  setState(() {
                                    switched = !switched;
                                  });
                                }
                            )
                        ),
                        Expanded(
                            flex:1,
                            child: Text(
                                "Boutique",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: switched ? Colors.brown : Colors.grey
                                )
                            )
                        ),
                      ]
                  ),
                  const Divider(height:30, thickness:2),
                  formConnex(switched, connected, connex)
                ]
            ),
            Column(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => InscPage(switched: switched)),
                        );
                      },
                      child: Text(
                          switched ? "Inscription boutique" : "Inscription joueur",
                          style: TextStyle(
                              color: switched ? Colors.brown : Colors.orange
                          )
                      )
                  )
                ]
            )
          ],
    );
  }

  Widget formConnex(bool boolean,String connected, connex) {
    return Form(
        key:_formKey,
        child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(top:15, bottom:10, left:15, right:15),
                      child: TextFormField(
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: boolean ? "Identifiant boutique" : "Identifiant joueur",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          )
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Veuillez remplir ce champs";
                          }
                          return null;
                        }
                      ),
                    )
                  ),
                ]
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom:10, left:15, right:15),
                      child:TextFormField(
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: "Mot de passe",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          )
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Veuillez remplir ce champs";
                          }
                          return null;
                        }
                      )
                    ),
                  ),
                ]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: boolean ? Colors.brown : Colors.orange,
                    ),
                    onPressed: (){
                      if(_formKey.currentState!.validate()) {
                        connect(boolean, connex);
                      }
                    },
                    child: const Text("Connexion")
                  )
                ]
              )
            ]
        )
    );
  }

  void connect(boolean, connex) async {
    connected = await boolean ? connex.connexionBoutique(_idController.toString(), _mdpController.toString()) : connex.connexionUtilisateur(_idController.toString(), _mdpController.toString());
  }
}