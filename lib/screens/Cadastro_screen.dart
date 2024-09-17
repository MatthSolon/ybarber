import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ybarber/models/users.dart';

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
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: senha);
      
      User? usuario = userCredential.user;
      
      if (usuario != null) {
        UsersModel newUser = UsersModel(
          id: usuario.uid,
          email: email,
          nome: nome,
          telefone: telefone,
          tipo: 'cliente',
          isAvailable: true,
        );

        await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(newUser.id)
            .set(newUser.toMap());

        print('Usuário cadastrado com sucesso!');
      }
    } catch (e) {
      print('Erro ao cadastrar usuário: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text("Cadastro")),
      body: Padding(
        padding:  EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration:  InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: nomeController,
              decoration:  InputDecoration(labelText: "Nome"),
            ),
            TextField(
              controller: senhaController,
              decoration:  InputDecoration(labelText: "Senha"),
              obscureText: true,
            ),
            TextField(
              controller: confirmeSenhaController,
              decoration:  InputDecoration(labelText: "Confirme a Senha"),
              obscureText: true,
            ),
            TextField(
              controller: telefoneController,
              decoration:  InputDecoration(labelText: "Telefone"),
            ),
             SizedBox(height: 20),
            ElevatedButton(
              onPressed: cadastrarUsuario,
              child:  Text("Cadastrar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              }, 
              child:  Text("Já tem login? Acessar"),
            ),
          ],
        ),
      ),
    );
  }
}
