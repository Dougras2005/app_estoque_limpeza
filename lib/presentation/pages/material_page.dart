import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import necessário para DateFormat

class MaterialPage extends StatefulWidget {
  const MaterialPage({super.key}); // Adicionado const

  @override
  MaterialPageScreenState createState() => MaterialPageScreenState();
}

class MaterialPageScreenState extends State<MaterialPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _codigoController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _quantidadeController = TextEditingController();
  final TextEditingController _localController = TextEditingController();
  DateTime? _vencimento;

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (dataSelecionada != null && dataSelecionada != _vencimento) {
      setState(() {
        _vencimento = dataSelecionada;
      });
    }
  }

  void _cadastrarMaterial() {
    if (_formKey.currentState?.validate() ?? false) {
      print('Código: ${_codigoController.text}');
      print('Nome: ${_nomeController.text}');
      print('Quantidade: ${_quantidadeController.text}');
      print(
          'Vencimento: ${_vencimento != null ? DateFormat('dd/MM/yyyy').format(_vencimento!) : 'Não selecionado'}');
      print('Local: ${_localController.text}');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Material cadastrado com sucesso!')),
      );

      _codigoController.clear();
      _nomeController.clear();
      _quantidadeController.clear();
      _localController.clear();
      setState(() {
        _vencimento = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Material'), // Adicionado const
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Adicionado const
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _codigoController,
                  decoration: const InputDecoration(labelText: 'Código'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O código é obrigatório';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16), // Adicionado const
                TextFormField(
                  controller: _nomeController,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O nome é obrigatório';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16), // Adicionado const
                TextFormField(
                  controller: _quantidadeController,
                  decoration: const InputDecoration(labelText: 'Quantidade'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'A quantidade é obrigatória';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Por favor, insira um número válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16), // Adicionado const
                TextFormField(
                  controller: _localController,
                  decoration: const InputDecoration(labelText: 'Local'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O local é obrigatório';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16), // Adicionado const
                Row(
                  children: [
                    Text(
                      _vencimento != null
                          ? 'Vencimento: ${DateFormat('dd/MM/yyyy').format(_vencimento!)}'
                          : 'Vencimento: Não selecionado',
                    ),
                    const Spacer(), // Adicionado const
                    ElevatedButton(
                      onPressed: () => _selecionarData(context),
                      child: const Text('Selecionar Data'), // Adicionado const
                    ),
                  ],
                ),
                const SizedBox(height: 32), // Adicionado const
                Center(
                  child: ElevatedButton(
                    onPressed: _cadastrarMaterial,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12), // Adicionado const
                    ),
                    child: const Text('Cadastrar'), // Adicionado const
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
