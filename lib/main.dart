import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ybarber/screens/Configuracao_screen.dart';
import 'package:ybarber/screens/Perfil_screen.dart';
import 'package:ybarber/screens/AgendamentoF_screen.dart';
import 'package:ybarber/screens/Agendamento_screen.dart';
import 'package:ybarber/screens/cadastro_screen.dart';
import 'firebase_options.dart';
import 'package:ybarber/screens/Chose_screen.dart';
import 'screens/login_screen.dart';
import 'screens/Home_screen.dart';

void main() {
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ybarber());  
  
}


class ybarber extends StatelessWidget {
  const ybarber({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      
      title: 'Ybarber',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  ChoseScreen(title: 'Ybarber',),
      routes: {
      '/home': (context) => HomePage(),
      '/agendamento': (context) => AgendamentoPage(),
      '/agendamentos': (context) => AgendamentosFuturosPage(),
      '/perfil': (context) => PerfilPage(),
      '/configuracoes': (context) => ConfiguracoesPage(),
      '/login': (context) => LoginPage(),
      '/cadastro': (context) => CadastroPage(),
      },
    );
  }
}
