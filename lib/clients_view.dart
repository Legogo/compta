import 'package:flutter/material.dart';

import 'client_model.dart';

// doc::io
// https://docs.flutter.dev/cookbook/persistence/reading-writing-files

// example of structure os statelesswidgets :
// https://github.com/flutter/samples/blob/main/provider_shopper/lib/screens/cart.dart

// button full width
// https://www.flutterbeads.com/full-width-button-in-flutter/

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
          future: ClientDb.fetchClients(),
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

      // bottom right floating circle add button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, PanelClientEdit.routeAdd);
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}

// tuto sur les TextField
// https://blog.logrocket.com/the-ultimate-guide-to-text-fields-in-flutter/

///
/// text edit, client & adresse
///
class PanelClientEdit extends StatelessWidget {
  const PanelClientEdit({super.key, this.state = ClientViewState.none});

  final ClientViewState state;

  static const routeEdit = "/clients/edit";
  static const routeAdd = "/clients/add";

  @override
  Widget build(BuildContext context) {
    Client? cl;

    switch (state) {
      case ClientViewState.edit:
        //context has client in arguments ?
        //yes: given when clicked in parent view on client item
        cl = ModalRoute.of(context)!.settings.arguments as Client;
        break;
      case ClientViewState.add:
        cl = Client(name: "nouveau client", addr: "adresse du client");
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

    Client client = cl;

    return Scaffold(
        appBar: AppBar(title: const Text("Client")),
        body: ListView(
          children: [
            TextField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  labelText: client.name, hintText: "name of the client"),
              onChanged: (text) {
                client.name = text;
                print("field changed to : $text");
              },
            ),
          ],
        ));
  }
}
