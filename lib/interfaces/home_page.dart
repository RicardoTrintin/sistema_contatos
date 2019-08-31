import 'package:flutter/material.dart';
import 'package:sistema_contato/helpers/help_contacts.dart';
import 'package:sistema_contato/interfaces/contact_page.dart';

enum OrderOptions {orderac, orderdesc}

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  ContactHelper helper = ContactHelper();

  List<Contact> contacts = List();

  @override
  void initState() {

    super.initState();
    _getAllContacts();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<OrderOptions>(
            itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
              const PopupMenuItem<OrderOptions>(
                child: Text("AC/Empresa"),
                value: OrderOptions.orderac,
              ),
              const PopupMenuItem<OrderOptions>(
                child: Text("DESC/Empresa"),
                value: OrderOptions.orderdesc,
              ),
            ],
            onSelected: _orderContacts,
          )
        ],
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.white,


      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          "Adicionar",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        ),
        icon: Icon(
          Icons.person_add,
          color: Colors.white,
        ),
        backgroundColor: Colors.orange,
        onPressed: (){
          _showContactPage();
        },
      ),

      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: contacts.length,
          itemBuilder: buildItem
      ),
    );
  }

  Widget buildItem(context, index){
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: ListTile(
        onTap: (){
          _showContactPage(contact: contacts[index]);
        },
        title: Text(contacts[index].nome,
          style: TextStyle(fontSize: 22.0,
              fontWeight: FontWeight.bold
          ),
        ),

        subtitle: Text(contacts[index].telefone ?? "",
          style: TextStyle(fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
        trailing: Text(contacts[index].empresa ?? "",
          style: TextStyle(fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
      ),
      onDismissed: (direction){
        helper.deleteContact(contacts[index].id);
        contacts.removeAt(index);
        setState(() {

        });
      },
    );
  }





  void _showContactPage({Contact contact}) async {
    final contactReceiv = await Navigator.push(context, MaterialPageRoute(builder: (context) => ContactPage(contact: contact))
    );
    if(contactReceiv != null){
      if(contact != null){
        await helper.editContact(contactReceiv);
      }else {
        await helper.saveContact(contactReceiv);
      }
      _getAllContacts();
    }
  }

  void _getAllContacts(){
    helper.getAllContacts().then((list){
      setState(() {
        contacts = list;
      });
    });
  }

  void _orderContacts(OrderOptions result){
    switch(result){
      case OrderOptions.orderac:
        contacts.sort((a, b){
          return a.empresa.toLowerCase().compareTo(b.empresa.toLowerCase());
        });
        break;
      case OrderOptions.orderdesc:
        contacts.sort((a, b){
          return b.empresa.toLowerCase().compareTo(a.empresa.toLowerCase());
        });
        break;
    }
    setState(() {

    });
  }

}
