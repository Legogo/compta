class Client {
  const Client({this.name = "", this.adresse = ""});

  final String name;
  final String adresse;
}

enum ClientViewState {
  edit,
  add,
}
