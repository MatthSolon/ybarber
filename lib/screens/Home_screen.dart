import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Bem-vindo, Usuário!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Botão para agendar serviço
            ElevatedButton.icon(
              icon: Icon(Icons.calendar_today),
              label: Text("Agendar Serviço"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/agendamento');
              },
            ),
            SizedBox(height: 20),

            // Botão para ver agendamentos futuros
            ElevatedButton.icon(
              icon: Icon(Icons.list_alt),
              label: Text("Ver Agendamentos"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/agendamentos');
              },
            ),
            SizedBox(height: 20),

            // Botão para acessar perfil do usuário
            ElevatedButton.icon(
              icon: Icon(Icons.person),
              label: Text("Perfil"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/perfil');
              },
            ),
            SizedBox(height: 40),

            // Informações adicionais ou notificações
            Text(
              "Agendamentos recentes:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            
          ],
        ),
      ),
    );
  }
}
