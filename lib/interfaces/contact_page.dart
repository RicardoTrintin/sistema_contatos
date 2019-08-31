import 'package:flutter/material.dart';
import 'package:sistema_contato/helpers/help_contacts.dart';

class ContactPage extends StatefulWidget {

  final Contact contact;

  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  final _nomeControler = TextEditingController();
  final _cargoControler = TextEditingController();
  final _empresaControler = TextEditingController();
  final _tipoEmpresaControler = TextEditingController();
  final _telefoneControler = TextEditingController();
  final _emailControler = TextEditingController();
  final _assuntoControler = TextEditingController();

  final _nameFocus = FocusNode();

  bool _userEdited = false;
  Contact _editContact;

  @override
  void initState() {
    super.initState();

    if(widget.contact == null){
      _editContact = Contact();
    }else(
      _editContact = Contact.fromMap(widget.contact.toMap())
    );

    _nomeControler.text = _editContact.nome;
    _cargoControler.text = _editContact.cargo;
    _empresaControler.text = _editContact.empresa;
    _tipoEmpresaControler.text = _editContact.tipoEmpresa;
    _telefoneControler.text = _editContact.telefone;
    _emailControler.text = _editContact.email;
    _assuntoControler.text = _editContact.assunto;

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope (
      onWillPop: _butonBack,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text(_editContact.nome ?? "Novo contato"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text(
            "Salvar",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
          ),
          icon: Icon(
            Icons.save,
            color: Colors.white,
          ),
          backgroundColor: Colors.orange,
          onPressed: (){
            if(_editContact.nome != null && _editContact.nome.isNotEmpty){
              Navigator.pop(context, _editContact);
            }else{
              FocusScope.of(context).requestFocus(_nameFocus);
            }

          },
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _nomeControler,
                focusNode: _nameFocus,
                decoration: InputDecoration(labelText: "Nome"),
                onChanged: (text){
                  _userEdited = true;
                  setState(() {
                    _editContact.nome = text;
                  });
                },
              ),
              TextField(
                controller: _cargoControler,
                decoration: InputDecoration(labelText: "Cargo"),
                onChanged: (text){
                  _userEdited = true;
                  _editContact.cargo = text;
                },
              ),
              TextField(
                controller: _empresaControler,
                decoration: InputDecoration(labelText: "Empresa"),
                onChanged: (text){
                  _userEdited = true;
                  _editContact.empresa = text;
                },
              ),
              TextField(
                controller: _tipoEmpresaControler,
                decoration: InputDecoration(labelText: "Tipo da Empresa"),
                onChanged: (text){
                  _userEdited = true;
                  _editContact.tipoEmpresa = text;
                },
              ),
              TextField(
                controller: _telefoneControler,
                decoration: InputDecoration(labelText: "Telefone"),
                onChanged: (text){
                  _userEdited = true;
                  _editContact.telefone = text;
                },
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: _emailControler,
                decoration: InputDecoration(labelText: "E-Mail"),
                onChanged: (text){
                  _userEdited = true;
                  _editContact.email = text;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: _assuntoControler,
                decoration: InputDecoration(labelText: "Assunto"),
                onChanged: (text){
                  _userEdited = true;
                  _editContact.assunto = text;
                },
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _butonBack(){
    if(_userEdited){
      showDialog(context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Descartar Alterações?"),
            content: Text("Se sair as alterações serão perdidas"),
            actions: <Widget>[
              FlatButton(
                color: Colors.orange,
                textColor: Colors.white,
                child: Text("Cancelar"),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                color: Colors.orange,
                textColor: Colors.white,
                child: Text("Sim"),
                onPressed: (){
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              )
            ],
          );
        }
      );
      return Future.value(false);
    }else{
      return Future.value(true);
    }
  }

 /* Widget campoText(String label, TextEditingController controller, TextInputType type, String text, Function teste(texto)){
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      onChanged: teste,
    );
  }*/

}
