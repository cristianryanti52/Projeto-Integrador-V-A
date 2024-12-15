import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/contact.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Hive
  await Hive.initFlutter();

  // Registra o adapter do Hive
  Hive.registerAdapter(ContactAdapter());

  // Abre a box de contatos
  await Hive.openBox<Contact>('contactsBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Criando um esquema de cores a partir de uma seed color
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.tealAccent,
      brightness: Brightness.dark,
    );

    final ThemeData themeData = ThemeData(
      colorScheme: colorScheme,
      fontFamily: 'Roboto',
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: Colors.tealAccent,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: const TextStyle(color: Colors.white70),
      ),
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Colors.black54,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.tealAccent),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.secondary,
      ),
    );

    return MaterialApp(
      title: 'Contatos Futurísticos',
      theme: themeData,
      home: const HomePage(),
    );
  }
}
