import 'package:flutter/material.dart';

class AgendamentosFuturosPage extends StatelessWidget {
  const AgendamentosFuturosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agendamentos Futuros")),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Corte de Cabelo - Maria"),
            subtitle: const Text("02/09/2024 - 15:00"),
            trailing: ElevatedButton(
              onPressed: () {},
              child: const Text("Cancelar"),
            ),
          ),
          ListTile(
            title: const Text("Manicure - João"),
            subtitle: const Text("05/09/2024 - 10:00"),
            trailing: ElevatedButton(
              onPressed: () {},
              child: const Text("Cancelar"),
            ),
          ),
        ],
      ),
    );
  }
}
