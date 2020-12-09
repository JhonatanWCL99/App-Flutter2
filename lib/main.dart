import 'package:flutter/material.dart';
import 'package:login/add_editclient.dart';
import 'package:login/db/database.dart';
import 'package:login/model/client_model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SqFlite',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Flutter II"),
        actions: <Widget>[
          RaisedButton(
            color: Theme.of(context).primaryColor,
            onPressed: () {
              ClientDatabaseProvider.db.deleteAllClient();
              setState(() {});
            },
            child: Text('Eliminar Todo',
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: Colors.black)),
          )
        ],
      ),
      body: FutureBuilder<List<Client>>(
        //llamamos al método, que está en la carpeta db file database.dart
        future: ClientDatabaseProvider.db.getAllClients(),
        builder: (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),

              //Contar todos los registros
              itemCount: snapshot.data.length,

              //todos los registros que se encuentran en la tabla de cliente se pasan a
              //un elemento Elemento de cliente - snapshot.data [index];
              itemBuilder: (BuildContext context, int index) {
                Client item = snapshot.data[index];

                //eliminar un registro para id
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.red),
                  onDismissed: (diretion) {
                    ClientDatabaseProvider.db.deleteClientWithId(item.id);
                  },

                  //Ahora pintamos la lista con todos los registros, que tendrán un número, nombre, dirección, teléfono
                  child: ListTile(
                    title: Text(item.name),
                    subtitle: Text(item.phone),
                    leading: CircleAvatar(child: Text(item.id.toString())),

                    //Si pulsamos una de las tarjetas, nos lleva a la página para editar, con los datos onTap:
                    //Este método está en el archivo add_editclient.dart
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddEditClient(
                                true,

                                //Aquí está el registro que queremos editar
                                client: item,
                              )));
                    },
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),

      //Este botón nos lleva al método add new register, que se encuentra en el archivo add_editclient.dart
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddEditClient(false)));
        },
      ),
    );
  }
}
