class Client {
  int id;
  String name;
  String direccion;
  String phone;

  Client({this.id, this.name, this.direccion, this.phone});

  //Para insertar los datos en la bd, necesitamos convertirlo en un Map
  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "direccion": direccion,
        "phone": phone,
      };

  //para recibir los datos necesitamos pasarlo de Map a json
  factory Client.fromMap(Map<String, dynamic> json) => new Client(
        id: json["id"],
        name: json["name"],
        direccion: json["direccion"],
        phone: json["phone"],
      );
}
