import 'package:flutter/material.dart';

class AgendamentoPage extends StatelessWidget {
  const AgendamentoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agendar Serviço")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: "Selecione o Serviço"),
              items: const [
                DropdownMenuItem(value: "corte", child: Text("Corte de Cabelo")),
                DropdownMenuItem(value: "manicure", child: Text("Manicure")),
              ],
              onChanged: (value) {},
            ),
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: "Selecione o Funcionário"),
              items: const [
                DropdownMenuItem(value: "maria", child: Text("Maria")),
                DropdownMenuItem(value: "joao", child: Text("João")),
              ],
              onChanged: (value) {},
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Data e Hora"),
              onTap: () {
                // Implemente um seletor de data/hora
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Confirmar Agendamento"),
            ),
          ],
        ),
      ),
    );
  }
}
