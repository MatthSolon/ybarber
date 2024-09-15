import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CadastroPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmeSenhaController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();

  CadastroPage({super.key});

  Future<void> cadastrarUsuario() async {
    String email = emailController.text;
    String nome = nomeController.text;
    String senha = senhaController.text;
    String telefone = telefoneController.text;

    if (senha != confirmeSenhaController.text) {
      print('As senhas não coincidem');
      return;
    }

    try {
      // Cadastro do usuário no Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: senha);
      
      User? usuario = userCredential.user;
      
      if (usuario != null) {
        // Armazena dados adicionais no Firestore, vinculando ao UID do usuário
        await FirebaseFirestore.instance.collection('usuarios').doc(usuario.uid).set({
          'email': email,
          'nome': nome,
          'telefone': telefone,
          'tipo': 'cliente', // Exemplo de campo extra
        });

        print('Usuário cadastrado com sucesso!');
      }
    } catch (e) {
      print('Erro ao cadastrar usuário: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cadastro")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: "Nome"),
            ),
            TextField(
              controller: senhaController,
              decoration: const InputDecoration(labelText: "Senha"),
              obscureText: true,
            ),
            TextField(
              controller: confirmeSenhaController,
              decoration: const InputDecoration(labelText: "Confirme a Senha"),
              obscureText: true,
            ),
            TextField(
              controller: telefoneController,
              decoration: const InputDecoration(labelText: "Telefone"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: cadastrarUsuario,
              child: const Text("Cadastrar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              }, 
              child: const Text("Já tem login? Acessar"),
            ),
          ],
        ),
      ),
    );
  }
}
