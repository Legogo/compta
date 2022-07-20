import 'dart:async' show Future;
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

import 'client_model.dart';

// doc::io
// https://docs.flutter.dev/cookbook/persistence/reading-writing-files

// example of structure os statelesswidgets :
// https://github.com/flutter/samples/blob/main/provider_shopper/lib/screens/cart.dart

// button full width
// https://www.flutterbeads.com/full-width-button-in-flutter/

Future<List<Client>> fetchClients() async {
  String response;
  response = await rootBundle.loadString("database/clients.json");

  //print(response);

  // https://api.flutter.dev/flutter/dart-convert/jsonDecode.html
  dynamic json = jsonDecode(response);

  // https://www.bezkoder.com/dart-list/
  List<Client> list = [];

  for (int i = 0; i < json.length; i++) {
    var jsonClient = json[i];
    var client = Client(name: jsonClient['name'], adresse: jsonClient["addr"]);
    list.add(client);
  }

  print("found x${list.length} client(s)");

  return list;
}

/// listing of clients
/// using future
///
class PanelClients extends StatelessWidget {
  const PanelClients({super.key});

  // https://docs.flutter.dev/cookbook/navigation/navigate-with-arguments
  static const routeName = "/clients";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Clients",
        textAlign: TextAlign.center,
      )),
      body: FutureBuilder<List<Client>>(
          future: fetchClients(),
          builder: (context, snapshot) {
            // on fetch finished
            if (snapshot.hasData) {
              List<Client> clients = snapshot.data!;
              print("snapshot has data, display clients list");

              return ListView.builder(
                  itemCount: clients.length,
                  itemBuilder: (context, index) {
                    Client cl = clients[index];
                    return ListTile(
                        title: Text(cl.name),
                        onTap: () {
                          Navigator.pushNamed(
                              context, PanelClientEdit.routeEdit,
                              arguments: cl);
                        });
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, PanelClientEdit.routeAdd);
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.navigation),
      ),
    );
  }
}

///
/// text edit, client & adresse
///
class PanelClientEdit extends StatelessWidget {
  const PanelClientEdit({super.key, this.state = ClientViewState.edit});

  final ClientViewState state;

  static const routeEdit = "/clients/edit";
  static const routeAdd = "/clients/add";

  @override
  Widget build(BuildContext context) {
    Client? cl;

    switch (state) {
      case ClientViewState.edit:
        cl = ModalRoute.of(context)!.settings.arguments as Client;
        break;
      case ClientViewState.add:
        cl = const Client(name: "nouveau client", adresse: "adresse du client");
        break;
      default:
        print("NOT IMPLEM");
        break;
    }

    if (cl == null) {
      return const Scaffold(
        body: Text("nope"),
      );
    }

    return Scaffold(
        appBar: AppBar(title: const Text("Client")),
        body: ListView(
          children: [
            TextField(
              decoration: InputDecoration(labelText: cl.name),
              onChanged: (text) {
                print("field changed to : $text");
              },
              onSubmitted: (text) {
                print("field submited : $text");
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: cl.adresse),
              onChanged: (text) {
                print("field changed to : $text");
              },
              onSubmitted: (text) {
                print("field submited : $text");
              },
            ),
          ],
        ));
  }
}
