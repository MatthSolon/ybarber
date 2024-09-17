import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ybarber/models/Services.dart';
import 'package:ybarber/models/Users.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  _ConfiguracoesPage createState() => _ConfiguracoesPage();
}

class _ConfiguracoesPage extends State<ConfiguracoesPage> {
  final _servicoNomeController = TextEditingController();
  final _servicoPrecoController = TextEditingController();
  final _servicoTempoController = TextEditingController();

  final _usuarioNomeController = TextEditingController();
  final _usuarioTelefoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _cadastrarServicos() async {
    if (_formKey.currentState!.validate()) {
      try {
        ServiceModel servico = ServiceModel(
          id: '', 
          nome: _servicoNomeController.text,
          preco: double.parse(_servicoPrecoController.text),
          tempo: _servicoTempoController.text,
        );

        await FirebaseFirestore.instance.collection('Servicos').add(servico.toMap());

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Serviço cadastrado com sucesso!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao cadastrar serviço: $e')),
        );
      }
    }
  }

  Future<void> _cadastrarFuncionario() async {
    if (_formKey.currentState!.validate()) {
      try {
        UsersModel funcionario = UsersModel(
          id: '', 
          email: '', 
          nome: _usuarioNomeController.text,
          telefone: _usuarioTelefoneController.text,
          tipo: 'funcionario',
          isAvailable: true,
        );

        await FirebaseFirestore.instance.collection('employees').add(funcionario.toMap());

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Funcionário cadastrado com sucesso!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao cadastrar funcionário: $e')),
        );
      }
    }
  }

  Future<bool> isOwner() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('usuarios')
          .where('email', isEqualTo: user.email)
          .get();
      if (snapshot.docs.isNotEmpty) {
        String tipo = snapshot.docs.first.get('tipo');
        return tipo == 'Owner';
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isOwner(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data == true) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Cadastro de Serviços e Funcionários'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const Text('Cadastrar Serviço', style: TextStyle(fontSize: 18)),
                    TextFormField(
                      controller: _servicoNomeController,
                      decoration: const InputDecoration(labelText: 'Nome do Serviço'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o nome do serviço';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _servicoPrecoController,
                      decoration: const InputDecoration(labelText: 'Preço do Serviço'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o preço';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _servicoTempoController,
                      decoration: const InputDecoration(labelText: 'Tempo do Serviço'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o tempo do serviço';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _cadastrarServicos,
                      child: const Text('Cadastrar Serviço'),
                    ),
                    const SizedBox(height: 32),
                    const Text('Cadastrar Funcionário', style: TextStyle(fontSize: 18)),
                    TextFormField(
                      controller: _usuarioNomeController,
                      decoration: const InputDecoration(labelText: 'Nome do Funcionário'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o nome do funcionário';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _usuarioTelefoneController,
                      decoration: const InputDecoration(labelText: 'telefone do Funcionário'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o telefone do funcionário';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _cadastrarFuncionario,
                      child: const Text('Cadastrar Funcionário'),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(title: Text('Acesso Negado')),
            body: Center(child: Text('Acesso restrito!')),
          );
        }
      },
    );
  }
}
