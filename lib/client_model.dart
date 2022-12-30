import 'dart:async' show Future;
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

import 'clients_view.dart';

class Client {
  Client({this.name = "", this.addr = ""});

  String name;
  String addr;
}

enum ClientViewState {
  none,
  edit,
  add,
}

class ClientDb {
  ///
  /// get clients data from json database object
  /// returns a list of Client
  ///
  static Future<List<Client>> fetchClients() async {
    String response;
    response = await rootBundle.loadString("database/clients.json");

    //print(response);

    // https://api.flutter.dev/flutter/dart-convert/jsonDecode.html
    dynamic json = jsonDecode(response);

    // https://www.bezkoder.com/dart-list/
    List<Client> list = [];

    for (int i = 0; i < json.length; i++) {
      var jsonClient = json[i];
      var client = Client(name: jsonClient['name'], addr: jsonClient["addr"]);
      list.add(client);
    }

    print("found x${list.length} client(s)");

    return list;
  }
}
