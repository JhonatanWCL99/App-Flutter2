import 'package:flutter/material.dart';
import 'package:login/model/client_model.dart';
import 'package:login/db/database.dart';

class AddEditClient extends StatefulWidget {
  final bool edit;
  final Client client;

  AddEditClient(this.edit, {this.client})
      : assert(edit == true || client == null);

  @override
  _AddEditClientState createState() => _AddEditClientState();
}

class _AddEditClientState extends State<AddEditClient> {
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController direccionEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    //si pulsa el botón para editarlo debe pasar a true,
    //crear una instancia del nombre direccion y el teléfono en su controlador respectivo, (vincularlos a cada controlador)
    if (widget.edit == true) {
      nameEditingController.text = widget.client.name;
      direccionEditingController.text = widget.client.direccion;
      phoneEditingController.text = widget.client.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.edit ? "Editar Cliente" : "Adicionar cliente"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlutterLogo(
                  size: 300,
                ),
                //si se trata de un nuevo registro, pide introducir datos, pero
                //pinta los datos traídos en el elemento
                textFormField(nameEditingController, "Name", "Enter Name",
                    Icons.person, widget.edit ? widget.client.name : "name"),
                textFormFieldPhone(
                    phoneEditingController,
                    "Phone",
                    "Enter phone",
                    Icons.person,
                    widget.edit ? widget.client.phone : "phone"),
                textFormFielddireccion(
                    direccionEditingController,
                    "direccion",
                    "Enter direccion",
                    Icons.person,
                    widget.edit ? widget.client.phone : "direccion"),

                RaisedButton(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Guardar',
                    style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: Colors.white),
                  ),
                  onPressed: () async {
                    if (!_formKey.currentState.validate()) {
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')));
                    } else if (widget.edit == true) {
                      ClientDatabaseProvider.db.updateClient(new Client(
                          name: nameEditingController.text,
                          direccion: direccionEditingController.text,
                          phone: phoneEditingController.text,
                          id: widget.client.id));
                      Navigator.pop(context);
                    } else {
                      await ClientDatabaseProvider.db.addClientToDatabase(
                          new Client(
                              name: nameEditingController.text,
                              direccion: direccionEditingController.text,
                              phone: phoneEditingController.text));
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  textFormField(TextEditingController t, String label, String hint,
      IconData iconData, String initialValue) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
        },
        controller: t,
        //keyboardType: TextInputType.number,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
            prefixIcon: Icon(iconData),
            hintText: label,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }

  textFormFieldPhone(TextEditingController t, String label, String hint,
      IconData iconData, String initialValue) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
        },
        controller: t,
        keyboardType: TextInputType.number,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
            prefixIcon: Icon(iconData),
            hintText: label,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }

  textFormFielddireccion(TextEditingController t, String label, String hint,
      IconData iconData, String initialValue) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
        },
        controller: t,
        //keyboardType: TextInputType.number,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
            prefixIcon: Icon(iconData),
            hintText: label,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
