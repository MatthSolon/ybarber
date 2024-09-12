import 'package:flutter/material.dart';

class AgendamentoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Agendar Serviço")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField(
              decoration: InputDecoration(labelText: "Selecione o Serviço"),
              items: [
                DropdownMenuItem(child: Text("Corte de Cabelo"), value: "corte"),
                DropdownMenuItem(child: Text("Manicure"), value: "manicure"),
              ],
              onChanged: (value) {},
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(labelText: "Selecione o Funcionário"),
              items: [
                DropdownMenuItem(child: Text("Maria"), value: "maria"),
                DropdownMenuItem(child: Text("João"), value: "joao"),
              ],
              onChanged: (value) {},
            ),
            TextField(
              decoration: InputDecoration(labelText: "Data e Hora"),
              onTap: () {
                // Implemente um seletor de data/hora
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text("Confirmar Agendamento"),
            ),
          ],
        ),
      ),
    );
  }
}
