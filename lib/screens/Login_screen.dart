import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  Future<void> loginComEmailSenha() async {
    String email = emailController.text;
    String senha = senhaController.text;

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: senha);
      
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuário autenticado com sucesso: ${userCredential.user?.email}')));
      Navigator.pushNamed(context, '/home');
    } catch (e) {
     ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao autenticar: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: senhaController,
              decoration: const InputDecoration(labelText: "Senha"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loginComEmailSenha,
              child: const Text("Login"),
            ),
            TextButton(
              onPressed: () {}, 
              child: const Text("Esqueci minha senha")),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cadastro');
              }, 
              child: const Text("Registrar")),
          ],
        ),
      ),
    );
  }
}