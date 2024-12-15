import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/contact.dart';
import 'add_contact_page.dart';
import 'contact_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Box<Contact> contactsBox;

  @override
  void initState() {
    super.initState();
    contactsBox = Hive.box<Contact>('contactsBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Contatos'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: contactsBox.listenable(),
        builder: (context, Box<Contact> box, _) {
          if (box.values.isEmpty) {
            return const Center(
              child: Text('Nenhum contato cadastrado'),
            );
          }

          final contacts = box.values.toList();

          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return Card(
                color: Colors.black45,
                child: ListTile(
                  title: Text(contact.name,
                      style: const TextStyle(color: Colors.tealAccent)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ContactDetailsPage(contactIndex: index),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddContactPage(),
            ),
          );
        },
      ),
    );
  }
}
