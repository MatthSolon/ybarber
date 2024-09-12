import 'package:flutter/material.dart';

class ChoseScreen extends StatefulWidget {
  const ChoseScreen({super.key, required this.title});

  final String title;

  @override
  State<ChoseScreen> createState() => _ChoseScreenState();
}

class _ChoseScreenState extends State<ChoseScreen> {
  void _goToLoginScreen() {
    Navigator.of(context).pushReplacementNamed('/login');   
}
void _goToCadastroScreen() {
    Navigator.of(context).pushReplacementNamed('/cadastro');    
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             const Text(
              'Seja Bem vindo',
              style: TextStyle(fontSize: 24,  color: Color.fromARGB(255, 255, 255, 255)),
            ),
             const SizedBox(height: 16),
            Image.asset(
              'imagens/logo.png',
              height: 300,
            ),
            
             const SizedBox(height: 16),
             const Text(
              'Marque seu horario com facilidade e rapidez, tudo com a palma de sua mão',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 255, 255, 255)),
            ),
             const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //botão login
                ElevatedButton(
                  onPressed: _goToLoginScreen,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:   Colors.blue,
                    foregroundColor: Colors.white,
                    padding:   EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    textStyle:   TextStyle(fontSize: 16),
                  ),
                  child:   Text('Login', ),
                ),
                  SizedBox(width: 16),
                  //botão cadastro
                ElevatedButton(
                  onPressed: _goToCadastroScreen,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:   Colors.blueGrey,
                    foregroundColor: Colors.white,
                    padding:   EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    textStyle:   TextStyle(fontSize: 16,),
                  ),
                  child:   Text('Cadastro'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

