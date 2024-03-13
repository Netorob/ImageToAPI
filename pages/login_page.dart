import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  DateTime? _dateTime; // Inicializa _dateTime como nulo
  
  String email = '';
  String senha = '';
  String nome = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  child: Image.asset('assets/images/inovisao.png'),
                ),
                const SizedBox(height: 20), // Adiciona um espaço entre os campos de texto e o DatePicker
                TextField(
                  onChanged: (text) {
                    nome = text;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Nome:',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20), // Adiciona um espaço entre os campos de texto e o DatePicker
                TextField(
                  onChanged: (text) {
                    email = text;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email:',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20), // Adiciona um espaço entre os campos de texto e o DatePicker
                TextField(
                  onChanged: (text) {
                    senha = text;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20), // Adiciona um espaço entre os campos de texto e o DatePicker
                ElevatedButton(
                  onPressed: () {
                    _selectDate(context); // Chama a função para selecionar a data
                  },
                  child: const Text('Selecione a Data'),
    
                ),
                const SizedBox(height: 20), // Adiciona um espaço abaixo do DatePicker
                if (_dateTime != null)
                  Text(
                    'Data selecionada: ${_dateTime!.day}/${_dateTime!.month}/${_dateTime!.year}',
                    style: const TextStyle(fontSize: 16),
                  ),
    
                const SizedBox(height: 20),
                ElevatedButton(onPressed:() {
                  if(email == 'teste' && senha == '123'){
                    print('Acesso permitido para $nome');
                    Navigator.of(context).pushNamed('/upload');
                  }else{
                    print('Acesso negado');
                  }
                }, child: const Text('Enviar')),
              ],
            ),
          ),
        ),
    ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dateTime = picked;
      });
    }
  }
}
