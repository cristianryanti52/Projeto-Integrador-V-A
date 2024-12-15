import 'package:hive/hive.dart';

part 'contact.g.dart';

@HiveType(typeId: 0) // O typeId deve ser único para cada modelo Hive
class Contact {
  @HiveField(0)
  String name;

  @HiveField(1)
  String phone;

  @HiveField(2)
  String email;

  Contact({
    required this.name,
    required this.phone,
    required this.email,
  });
}
