import 'package:flutter/material.dart';

class AgendamentosFuturosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Agendamentos Futuros")),
      body: ListView(
        children: [
          ListTile(
            title: Text("Corte de Cabelo - Maria"),
            subtitle: Text("02/09/2024 - 15:00"),
            trailing: ElevatedButton(
              onPressed: () {},
              child: Text("Cancelar"),
            ),
          ),
          ListTile(
            title: Text("Manicure - João"),
            subtitle: Text("05/09/2024 - 10:00"),
            trailing: ElevatedButton(
              onPressed: () {},
              child: Text("Cancelar"),
            ),
          ),
        ],
      ),
    );
  }
}
