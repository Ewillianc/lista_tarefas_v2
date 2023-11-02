import 'package:flutter/material.dart';
import 'package:lista_tarefas_v2/page/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Compras',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 81, 223, 204)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
