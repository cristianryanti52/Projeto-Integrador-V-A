import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/contact.dart';
import 'edit_contact_page.dart';

class ContactDetailsPage extends StatefulWidget {
  final int contactIndex;
  const ContactDetailsPage({super.key, required this.contactIndex});

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  late Box<Contact> box;

  @override
  void initState() {
    super.initState();
    box = Hive.box<Contact>('contactsBox');
  }

  void _deleteContact() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir contato'),
        content: const Text('Deseja realmente excluir este contato?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await box.deleteAt(widget.contactIndex);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sempre que o build é chamado, buscamos a versão mais atualizada do contato
    final contact = box.getAt(widget.contactIndex)!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Nome: ${contact.name}',
                style: const TextStyle(color: Colors.tealAccent, fontSize: 18)),
            const SizedBox(height: 10),
            Text('Telefone: ${contact.phone}',
                style: const TextStyle(color: Colors.white70, fontSize: 16)),
            const SizedBox(height: 10),
            Text('E-mail: ${contact.email}',
                style: const TextStyle(color: Colors.white70, fontSize: 16)),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            EditContactPage(contactIndex: widget.contactIndex),
                      ),
                    ).then((_) {
                      // Ao voltar da página de edição, forçamos a reconstrução desta página
                      setState(() {});
                    });
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Editar'),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: _deleteContact,
                  icon: const Icon(Icons.delete, color: Colors.red),
                  label: const Text('Excluir'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
