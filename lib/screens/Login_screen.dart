import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding:  EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Senha"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () {

            }, child: Text("Login")),
            TextButton(onPressed: () {}, child: Text("Esqueci minha senha")),
            TextButton(onPressed: () {Navigator.pushNamed(context, '/cadastro');}, child: Text("Registrar")),
          ],
        ),
      ),
    );
  }
}


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.pushReplacementNamed(context, '/register');  // Navega para a tela de cadastro
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao fazer login: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login do Proprietário')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
              
            ),
            
            TextButton(onPressed: () {}, child: Text("Esqueci minha senha")),
            TextButton(onPressed: () {Navigator.pushNamed(context, '/cadastro');}, child: Text("Registrar"))
          ],
        ),
      ),
    );
  }
}
/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  // Função para validar login
  Future<void> validarLogin() async {
    String email = emailController.text;
    String senha = senhaController.text;

    // Busca o documento no Firestore usando o email
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('clientes')
        .where('email', isEqualTo: email)
        .get();

    if (snapshot.docs.isNotEmpty) {
      // Usuário encontrado, vamos comparar as senhas
      var clienteData = snapshot.docs.first.data() as Map<String, dynamic>;

      if (clienteData['senha'] == senha) {
        // Login válido
        print('Login bem-sucedido!');
        // Aqui você pode redirecionar o usuário ou mostrar outra tela
      } else {
        // Senha incorreta
        print('Senha incorreta');
      }
    } else {
      // Nenhum usuário com o email fornecido foi encontrado
      print('Usuário não encontrado');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: senhaController,
              decoration: InputDecoration(labelText: "Senha"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                validarLogin(); // Chama a função para validar login
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
*/