import 'package:flutter/material.dart';

class ProdutosPage extends StatefulWidget {
  const ProdutosPage({super.key});

  @override
  ProdutosState createState() => ProdutosState();
}

class ProdutosState extends State<ProdutosPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _codigoController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _quantidadeController = TextEditingController();
  final TextEditingController _localController = TextEditingController();
  final TextEditingController _fornecedorController = TextEditingController();
  final TextEditingController _tipoCustomController = TextEditingController();
  final TextEditingController _dataEntradaController = TextEditingController();
  final TextEditingController _vencimentoController = TextEditingController();
  String? _tipo;

  void _cadastrarMaterial() {
    if (_formKey.currentState?.validate() ?? false) {
      final tipoFinal = _tipo == "Outro" ? _tipoCustomController.text : _tipo;

      print('Código: ${_codigoController.text}');
      print('Nome: ${_nomeController.text}');
      print('Quantidade: ${_quantidadeController.text}');
      print('Tipo: $tipoFinal');
      print('Data de Entrada: ${_dataEntradaController.text}');
      print('Vencimento: ${_vencimentoController.text}');
      print('Local: ${_localController.text}');
      print('ID do Fornecedor: ${_fornecedorController.text}');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Material cadastrado com sucesso!')),
      );

      _codigoController.clear();
      _nomeController.clear();
      _quantidadeController.clear();
      _localController.clear();
      _fornecedorController.clear();
      _tipoCustomController.clear();
      _dataEntradaController.clear();
      _vencimentoController.clear();
      setState(() {
        _tipo = null;
      });
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
        title: const Text('Cadastro de Produtos'),
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
                  controller: _codigoController,
                  decoration: inputDecoration.copyWith(labelText: 'Código'),
                  style: const TextStyle(color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O código é obrigatório';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
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
                  controller: _quantidadeController,
                  decoration: inputDecoration.copyWith(labelText: 'Quantidade'),
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.black),
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
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _tipo,
                  decoration: inputDecoration.copyWith(labelText: 'Tipo'),
                  items: ['Perecível', 'Não Perecível', 'Outro']
                      .map((tipo) => DropdownMenuItem(
                            value: tipo,
                            child: Text(
                              tipo,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _tipo = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O tipo é obrigatório';
                    }
                    return null;
                  },
                ),
                if (_tipo == "Outro")
                  TextFormField(
                    controller: _tipoCustomController,
                    decoration:
                        inputDecoration.copyWith(labelText: 'Descreva o Tipo'),
                    style: const TextStyle(color: Colors.black),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Descreva o tipo';
                      }
                      return null;
                    },
                  ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _dataEntradaController,
                  decoration:
                      inputDecoration.copyWith(labelText: 'Data de Entrada'),
                  keyboardType: TextInputType.datetime,
                  style: const TextStyle(color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'A data de entrada é obrigatória';
                    }
                    return null;
                  },
                ),
                if (_tipo == "Perecível" || _tipo == "Outro")
                  TextFormField(
                    controller: _vencimentoController,
                    decoration:
                        inputDecoration.copyWith(labelText: 'Vencimento'),
                    keyboardType: TextInputType.datetime,
                    style: const TextStyle(color: Colors.black),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'O vencimento é obrigatório';
                      }
                      return null;
                    },
                  ),
                const SizedBox(height: 32),
                Center(
                  child: ElevatedButton(
                    onPressed: _cadastrarMaterial,
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
