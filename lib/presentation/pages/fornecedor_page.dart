import 'package:flutter/material.dart';

class FornecedorPage extends StatefulWidget {
  const FornecedorPage({super.key});

  @override
  FornecedorState createState() => FornecedorState();
}

class FornecedorState extends State<FornecedorPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();

  void _cadastrarFornecedor() {
    if (_formKey.currentState?.validate() ?? false) {
      print('Nome: ${_nomeController.text}');
      print('Endereço: ${_enderecoController.text}');
      print('Telefone: ${_telefoneController.text}');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fornecedor cadastrado com sucesso!')),
      );

      // Limpar os campos após cadastro
      _nomeController.clear();
      _enderecoController.clear();
      _telefoneController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: Colors.blue[50],
      labelStyle: const TextStyle(color: Colors.black),
      hintStyle: const TextStyle(color: Colors.black54),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Fornecedor'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nomeController,
                  decoration: inputDecoration.copyWith(labelText: 'Nome'),
                  style: const TextStyle(color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O nome é obrigatório';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _enderecoController,
                  decoration: inputDecoration.copyWith(labelText: 'Endereço'),
                  style: const TextStyle(color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O endereço é obrigatório';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _telefoneController,
                  decoration: inputDecoration.copyWith(labelText: 'Telefone'),
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O telefone é obrigatório';
                    }
                    final regex = RegExp(r'^\d{10,11}$'); // 10 ou 11 dígitos
                    if (!regex.hasMatch(value)) {
                      return 'Por favor, insira um telefone válido (apenas números)';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                Center(
                  child: ElevatedButton(
                    onPressed: _cadastrarFornecedor,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Cadastrar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
