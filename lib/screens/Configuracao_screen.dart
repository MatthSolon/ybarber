import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ConfiguracoesPage extends StatefulWidget {
  @override
  _ConfiguracoesPage createState() => _ConfiguracoesPage();
}

class _ConfiguracoesPage extends State<ConfiguracoesPage> {
  final _serviceNameController = TextEditingController();
  final _servicePriceController = TextEditingController();
  final _employeeNameController = TextEditingController();
  final _employeeRoleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _serviceNameController.dispose();
    _servicePriceController.dispose();
    _employeeNameController.dispose();
    _employeeRoleController.dispose();
    super.dispose();
  }

  Future<void> _addService() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('services').add({
          'name': _serviceNameController.text,
          'price': double.parse(_servicePriceController.text),
        });
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

  Future<void> _addEmployee() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('employees').add({
          'name': _employeeNameController.text,
          'role': _employeeRoleController.text,
          'isAvailable': true, // Padrão disponível
        });
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

  // Verifica se o usuário logado é o proprietário
  bool _isOwner() {
    final user = _auth.currentUser;
    return user != null && user.email == 'proprietario@salon.com';  // Exemplo de e-mail do proprietário
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Serviços e Funcionários')),
      body: _isOwner()  // Verifica se o usuário é o proprietário
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    // Cadastro de Serviços
                    Text('Cadastrar Serviço', style: TextStyle(fontSize: 18)),
                    TextFormField(
                      controller: _serviceNameController,
                      decoration: InputDecoration(labelText: 'Nome do Serviço'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o nome do serviço';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _servicePriceController,
                      decoration: InputDecoration(labelText: 'Preço do Serviço'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o preço';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _addService,
                      child: Text('Cadastrar Serviço'),
                    ),

                    SizedBox(height: 32),

                    // Cadastro de Funcionários
                    Text('Cadastrar Funcionário', style: TextStyle(fontSize: 18)),
                    TextFormField(
                      controller: _employeeNameController,
                      decoration: InputDecoration(labelText: 'Nome do Funcionário'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o nome do funcionário';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _employeeRoleController,
                      decoration: InputDecoration(labelText: 'Função do Funcionário'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira a função do funcionário';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _addEmployee,
                      child: Text('Cadastrar Funcionário'),
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: Text(
                'Acesso restrito ao proprietário!',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            ),
    );
  }
}
