import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/contact.dart';

class EditContactPage extends StatefulWidget {
  final int contactIndex;
  const EditContactPage({super.key, required this.contactIndex});

  @override
  State<EditContactPage> createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    final box = Hive.box<Contact>('contactsBox');
    final contact = box.getAt(widget.contactIndex)!;
    _nameController = TextEditingController(text: contact.name);
    _phoneController = TextEditingController(text: contact.phone);
    _emailController = TextEditingController(text: contact.email);
  }

  void _updateContact() async {
    if (_formKey.currentState!.validate()) {
      final box = Hive.box<Contact>('contactsBox');
      final updatedContact = Contact(
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        email: _emailController.text.trim(),
      );

      await box.putAt(widget.contactIndex, updatedContact);

      Navigator.pop(context); // Volta à tela de detalhes
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text('Edite os dados do contato:',
                  style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe um nome';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: 'Telefone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe um telefone';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: 'E-mail'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe um e-mail';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateContact,
                child: const Text('Salvar Alterações'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
