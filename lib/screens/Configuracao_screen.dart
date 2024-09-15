import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  _ConfiguracoesPage createState() => _ConfiguracoesPage();
}

class _ConfiguracoesPage extends State<ConfiguracoesPage> {
  final _servicoNomeController = TextEditingController();
  final _servicoPrecoController = TextEditingController();
  final _usuarioNomeController = TextEditingController();
  final _employeeRoleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    _servicoNomeController.dispose();
    _servicoPrecoController.dispose();
    _usuarioNomeController.dispose();
    _employeeRoleController.dispose();
    super.dispose();
  }

  Future<void> _addServicos() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('Servicos').add({
          'name': _servicoNomeController.text,
          'price': double.parse(_servicoPrecoController.text),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Serviço cadastrado com sucesso!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao cadastrar serviço: $e')),
        );
      }
    }
  }

  Future<void> _addUsers() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('employees').add({
          'name': _usuarioNomeController.text,
          'role': _employeeRoleController.text,
          'isAvailable': true, // Padrão disponível
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Funcionário cadastrado com sucesso!')),
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
        // Pegue o campo 'tipo' do documento do usuário
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
                  title: const Text('Cadastro de Serviços e Funcionários')),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      const Text('Cadastrar Serviço',
                          style: TextStyle(fontSize: 18)),
                      TextFormField(
                        controller: _servicoNomeController,
                        decoration:
                            const InputDecoration(labelText: 'Nome do Serviço'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o nome do serviço';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _servicoPrecoController,
                        decoration: const InputDecoration(
                            labelText: 'Preço do Serviço'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o preço';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _addServicos,
                        child: const Text('Cadastrar Serviço'),
                      ),
                      const SizedBox(height: 32),
                      const Text('Cadastrar Funcionário',
                          style: TextStyle(fontSize: 18)),
                      TextFormField(
                        controller: _usuarioNomeController,
                        decoration: const InputDecoration(
                            labelText: 'Nome do Funcionário'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o nome do funcionário';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _employeeRoleController,
                        decoration: const InputDecoration(
                            labelText: 'Função do Funcionário'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira a função do funcionário';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _addUsers,
                        child: const Text('Cadastrar Funcionário'),
                      ),
                    ],
                  ),
                ),
              ));
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
