import 'package:compta_repo/client_model.dart';
import 'package:compta_repo/clients_view.dart';
import 'package:flutter/material.dart';

/*
  routes : https://docs.flutter.dev/cookbook/navigation/named-routes
*/

///
/// Homepage
///   clients
///   projects
///
class PanelHomepage extends StatelessWidget {
  const PanelHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    print("homapge:build");

    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Homepage",
        textAlign: TextAlign.center,
      )),
      body: ListView(
        children: [
          ListTile(
              onTap: () {
                //nav to clients
                Navigator.pushNamed(context, PanelClients.routeName);
              },
              title: const Text("Client(s)")),
          ListTile(
              onTap: () {
                print("not implem");
                //nav to clients
                //Navigator.pushNamed(context, "/");
              },
              title: const Text("Projet(s)")),
        ],
      ),
    );
  }
}
