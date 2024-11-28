import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import necessário para DateFormat

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
  DateTime? _vencimento;
  DateTime? _dataEntrada;
  String? _tipo;

  Future<void> _selecionarData(BuildContext context, bool isDataEntrada) async {
    final DateTime? dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (dataSelecionada != null) {
      setState(() {
        if (isDataEntrada) {
          _dataEntrada = dataSelecionada;
        } else {
          _vencimento = dataSelecionada;
        }
      });
    }
  }

  void _cadastrarMaterial() {
    if (_formKey.currentState?.validate() ?? false) {
      final tipoFinal = _tipo == "Outro" ? _tipoCustomController.text : _tipo;

      print('Código: ${_codigoController.text}');
      print('Nome: ${_nomeController.text}');
      print('Quantidade: ${_quantidadeController.text}');
      print('Tipo: $tipoFinal');
      print(
          'Data de Entrada: ${_dataEntrada != null ? DateFormat('dd/MM/yyyy').format(_dataEntrada!) : 'Não selecionada'}');
      print(
          'Vencimento: ${_vencimento != null ? DateFormat('dd/MM/yyyy').format(_vencimento!) : 'Não selecionado'}');
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
      setState(() {
        _vencimento = null;
        _dataEntrada = null;
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
                const SizedBox(height: 16),
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
                  controller: _fornecedorController,
                  decoration:
                      inputDecoration.copyWith(labelText: 'ID do Fornecedor'),
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O ID do fornecedor é obrigatório';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Por favor, insira um número válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _localController,
                  decoration: inputDecoration.copyWith(labelText: 'Local'),
                  style: const TextStyle(color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O local é obrigatório';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      _dataEntrada != null
                          ? 'Data de Entrada: ${DateFormat('dd/MM/yyyy').format(_dataEntrada!)}'
                          : 'Data de Entrada: Não selecionada',
                      style: const TextStyle(color: Colors.black),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () => _selecionarData(context, true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Selecionar Data'),
                    ),
                  ],
                ),
                if (_tipo == "Perecível" || _tipo == "Outro") ...[
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        _vencimento != null
                            ? 'Vencimento: ${DateFormat('dd/MM/yyyy').format(_vencimento!)}'
                            : 'Vencimento: Não selecionado',
                        style: const TextStyle(color: Colors.black),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () => _selecionarData(context, false),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Selecionar Data'),
                      ),
                    ],
                  ),
                ],
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
