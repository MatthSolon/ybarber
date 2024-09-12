import 'package:flutter/material.dart';



class CadastroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
            TextField(
              decoration: InputDecoration(labelText: "Confirme a Senha"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: Text("Cadastrar")),
            TextButton(onPressed: () {Navigator.pushNamed(context, '/login');}, child: Text("Ja tem login? acessar")),
          ],
        ),
      ),
    );
  }
}



/*

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  // Função para hash de senha (utilizando SHA-256)
  String hashSenha(String senha) {
    return sha256.convert(utf8.encode(senha)).toString();
  }

  // Função para cadastrar usuário no Firestore
  Future<void> cadastrarUsuario() async {
    String nome = nomeController.text;
    String email = emailController.text;
    String senha = senhaController.text;

    if (nome.isEmpty || email.isEmpty || senha.isEmpty) {
      print('Todos os campos devem ser preenchidos');
      return;
    }

    try {
      // Verifica se o email já está cadastrado
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('clientes')
          .where('email', isEqualTo: email)
          .get();

      if (snapshot.docs.isNotEmpty) {
        print('Email já cadastrado');
        return;
      }

      // Hash da senha antes de salvar
      String senhaHash = hashSenha(senha);

      // Salva os dados no Firestore
      await FirebaseFirestore.instance.collection('clientes').add({
        'nome': nome,
        'email': email,
        'senha': senhaHash, // Salva a senha já com o hash
      });

      print('Cadastro realizado com sucesso!');
      // Aqui você pode redirecionar o usuário para outra tela ou exibir uma mensagem de sucesso
    } catch (e) {
      print('Erro ao cadastrar usuário: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(labelText: "Nome"),
            ),
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
                cadastrarUsuario(); // Chama a função de cadastro ao clicar no botão
              },
              child: Text("Cadastrar"),
            ),
          ],
        ),
      ),
    );
  }
}



 */