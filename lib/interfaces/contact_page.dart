import 'package:flutter/material.dart';
import 'package:sistema_contato/helpers/help_contacts.dart';

class ContactPage extends StatefulWidget {
  final Contact contact;

  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  //CONTROL VARIABLES FOR TEXTFILDS
  final _nomeControler = TextEditingController();
  final _cargoControler = TextEditingController();
  final _empresaControler = TextEditingController();
  final _tipoEmpresaControler = TextEditingController();
  final _telefoneControler = TextEditingController();
  final _emailControler = TextEditingController();
  final _assuntoControler = TextEditingController();

  //VARIABLES THAT CONTROL TEXT COMPOUND VALIDATIONS
  final _nameFocus = FocusNode();
  final _cargoFocus = FocusNode();
  final _empresaFocus = FocusNode();
  final _telefoneFocus = FocusNode();

  //VARIABLE THAT CONTROLS IF THE USER CLICKED SOME FIELD FOR EDITING, IF CLICKED A DIALOG MESSAGE APPEARS
  bool _userEdited = false;

  //CONTACT CONTROL VARIABLE THAT WAS PASSED OR NOT FOR THIS SCREEN
  Contact _editContact;

  @override
  void initState() {
    super.initState();

    //TEST IF PASSED AS PARAMETER ANY CONTACT FOR THIS SCREEN
    // IF NOT VARIABLE _EDITCONTACT RECEIVES AN EMPTY CONTACT TO BE CREATED IF NOT,
    // RECEIVES MAP OF CONTACT THAT HAS BEEN PASSED AS PARAMETER
    if (widget.contact == null) {
      _editContact = Contact();
    } else
      (_editContact = Contact.fromMap(widget.contact.toMap()));

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
    return WillPopScope(
      //CALLS A FUNCTION TO CONTROL SCREEN BUTTON
      onWillPop: _butonBack,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: Colors.orange,
          title: Text(_editContact.nome ?? "Novo contato",
              style: TextStyle(color: Colors.white)),
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
          onPressed: () {
            //FILDE VALIDATION
            if (_editContact.nome != null &&
                _editContact.nome.isNotEmpty &&
                _editContact.empresa != null &&
                _editContact.empresa.isNotEmpty &&
                _editContact.telefone != null &&
                _editContact.telefone.isNotEmpty) {
              Navigator.pop(context, _editContact);
            } else if (_editContact.nome == null &&
                _editContact.nome.isEmpty &&
                _editContact.empresa != null &&
                _editContact.empresa.isEmpty &&
                _editContact.telefone != null &&
                _editContact.telefone.isNotEmpty) {
              FocusScope.of(context).requestFocus(_cargoFocus);
            } else if (_editContact.nome != null &&
                _editContact.nome.isNotEmpty &&
                _editContact.empresa == null &&
                _editContact.empresa.isEmpty &&
                _editContact.telefone != null &&
                _editContact.telefone.isEmpty) {
              FocusScope.of(context).requestFocus(_empresaFocus);
            } else if (_editContact.nome != null &&
                _editContact.nome.isNotEmpty &&
                _editContact.empresa != null &&
                _editContact.empresa.isNotEmpty &&
                _editContact.telefone == null &&
                _editContact.telefone.isEmpty) {
              FocusScope.of(context).requestFocus(_telefoneFocus);
            }
          },
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            //FIELDS WHERE THE CONTACT INFORMATION OR THE EMPTY FIELD APPEARS TO ADD A
            // CONTACT IF IT HAS NOT BEEN PASSED AS PARAMETER
            children: <Widget>[
              TextField(
                controller: _nomeControler,
                focusNode: _nameFocus,
                decoration: InputDecoration(
                    labelText: "Nome",
                    icon: Icon(Icons.person, color: Colors.orange),
                    hintText: "Informe o nome"),
                onChanged: (text) {
                  _userEdited = true;
                  setState(() {
                    _editContact.nome = text;
                  });
                },
              ),
              TextField(
                controller: _cargoControler,
                decoration: InputDecoration(
                    labelText: "Cargo",
                    icon: Icon(Icons.build, color: Colors.orange),
                    hintText: "Informe o cargo"),
                onChanged: (text) {
                  _userEdited = true;
                  _editContact.cargo = text;
                },
              ),
              TextField(
                controller: _empresaControler,
                decoration: InputDecoration(
                    labelText: "Empresa",
                    icon: Icon(Icons.business_center, color: Colors.orange),
                    hintText: "Informe a empresa"),
                onChanged: (text) {
                  _userEdited = true;
                  _editContact.empresa = text;
                },
              ),
              TextField(
                controller: _tipoEmpresaControler,
                decoration: InputDecoration(
                    labelText: "Tipo da Empresa",
                    icon: Icon(Icons.merge_type, color: Colors.orange),
                    hintText: "Informe o tipo da empresa"),
                onChanged: (text) {
                  _userEdited = true;
                  _editContact.tipoEmpresa = text;
                },
              ),
              TextField(
                controller: _telefoneControler,
                decoration: InputDecoration(
                    labelText: "Telefone",
                    icon: Icon(Icons.phone, color: Colors.orange),
                    hintText: "Informe o telefone"),
                onChanged: (text) {
                  _userEdited = true;
                  _editContact.telefone = text;
                },
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: _emailControler,
                decoration: InputDecoration(
                    labelText: "E-Mail",
                    icon: Icon(Icons.email, color: Colors.orange),
                    hintText: "Informe o E-Mail"),
                onChanged: (text) {
                  _userEdited = true;
                  _editContact.email = text;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: _assuntoControler,
                decoration: InputDecoration(
                    labelText: "Assunto",
                    icon: Icon(Icons.subject, color: Colors.orange),
                    hintText: "Informe o assunto do contato"),
                onChanged: (text) {
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

  //FUNCTION THAT CONTROLS AND PRESENTS A QUESTION DIALOGUE TO THE USER IF IT
  // WANTS OR NOT DISCLOSES THE CHANGES MADE TO THE CONTACT IF IT HAS BEEN EDITED
  Future<bool> _butonBack() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Descartar Alterações?"),
              content: Text("Se sair as alterações serão perdidas"),
              actions: <Widget>[
                FlatButton(
                  color: Colors.orange,
                  textColor: Colors.white,
                  child: Text("Cancelar"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  color: Colors.orange,
                  textColor: Colors.white,
                  child: Text("Sim"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
      //FALSE BACK TO onWillPop NOT TO LEAVE THE CONTACT PAGE SCREEN AUTOMATICALLY BECAUSE USER MAKES CHANGE TO CONTACT
      return Future.value(false);
    } else {
      //TRUE RETURNS TO onWillPop TO LEAVE SCREEN CONTACT_PAGE AUTOMATICALLY BECAUSE USER HAS NOT MADE CONTACT
      return Future.value(true);
    }
  }
}
