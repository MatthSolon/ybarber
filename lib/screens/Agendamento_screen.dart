import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ybarber/models/Appointment.dart';
import 'package:ybarber/models/Services.dart';
import 'package:ybarber/models/Users.dart';

class AgendamentoPage extends StatefulWidget {
  const AgendamentoPage({super.key});

  @override
  _AgendamentoPageState createState() => _AgendamentoPageState();
}

class _AgendamentoPageState extends State<AgendamentoPage> {
  final _dateController = TextEditingController();
  String? _selectedService;
  String? _selectFuncionario;
  DateTime? _selectedDate;
  bool _isLoading = true;

  List<ServiceModel> _services = [];
  List<UsersModel> _Funcionarios = [];

  @override
  void initState() {
    super.initState();
    _buscarServicosEFuncionarios();
  }

  Future<void> _buscarServicosEFuncionarios() async {
    try {
      
        QuerySnapshot serviceSnapshot =
          await FirebaseFirestore.instance.collection('Servicos').get();
      _services = serviceSnapshot.docs
          .map((doc) => ServiceModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();

      
      QuerySnapshot employeeSnapshot = await FirebaseFirestore.instance
          .collection('usuarios')
          .where('tipo', isEqualTo: 'funcionario')
          .get();

      _Funcionarios = employeeSnapshot.docs
          .map((doc) => UsersModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Erro ao buscar serviços e funcionários: $e');
    }
  }

  Future<void> _confirmarAgendamento() async {
    if (_selectedService == null ||
        _selectFuncionario == null ||
        _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos')),
      );
      return;
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final newAppointment = AppointmentModel(
          id: '', 
          isConfirmed: false,
          date: _selectedDate!,
          serviceId: _selectedService!,
          userId: user.uid,
        );

        await FirebaseFirestore.instance
            .collection('agendamentos')
            .add(newAppointment.toMap());

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Agendamento confirmado com sucesso!')),
        );
      }
    } catch (e) {
      print('Erro ao confirmar agendamento: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao confirmar agendamento: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agendar Serviço")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    decoration:
                        const InputDecoration(labelText: "Selecione o Serviço"),
                    items: _services.map((service) {
                      return DropdownMenuItem<String>(
                        value: service.id,
                        child: Text(service.nome),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedService = value;
                      });
                    },
                  ),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                        labelText: "Selecione o Funcionário"),
                    items: _Funcionarios.map((employee) {
                      return DropdownMenuItem<String>(
                        value: employee.id,
                        child: Text(employee.nome),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectFuncionario = value;
                      });
                    },
                  ),
                  TextField(
                    controller: _dateController,
                    decoration:
                        const InputDecoration(labelText: "Data e Hora"),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );

                      if (pickedDate != null) {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (pickedTime != null) {
                          setState(() {
                            _selectedDate = DateTime(pickedDate.year,
                                pickedDate.month, pickedDate.day, pickedTime.hour, pickedTime.minute);
                            _dateController.text = DateFormat('yyyy-MM-dd HH:mm')
                                .format(_selectedDate!);
                          });
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _confirmarAgendamento,
                    child: const Text("Confirmar Agendamento"),
                  ),
                ],
              ),
            ),
    );
  }
}
