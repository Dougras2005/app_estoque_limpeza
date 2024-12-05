import 'package:app_estoque_limpeza/data/model/fornecedor_model.dart';
import 'package:app_estoque_limpeza/data/model/material_model.dart';
import 'package:app_estoque_limpeza/data/repositories/fornecedor_repository.dart';
import 'package:app_estoque_limpeza/data/repositories/material_repositories.dart';
import 'package:app_estoque_limpeza/data/repositories/tipo_repositories.dart';
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
  final TextEditingController _fornecedorCustomController =
      TextEditingController(); // Novo campo para fornecedor personalizado
  final TextEditingController _tipoCustomController = TextEditingController();
  final TextEditingController _dataEntradaController = TextEditingController();
  final TextEditingController _vencimentoController = TextEditingController();

  String? _tipo;
  String? _fornecedor;
  List<String> _fornecedores =
      []; // Lista para armazenar fornecedores carregados

  // Instâncias dos repositórios
  final MaterialRepository _materialRepository = MaterialRepository();
  final TipoRepository _tipoRepository = TipoRepository();
  final FornecedorRepository _fornecedorRepository = FornecedorRepository();

  @override
  void initState() {
    super.initState();
    _listaDeFornecedores(); // Carrega os fornecedores ao inicializar
  }

  // Função para carregar a lista de fornecedores
  _listaDeFornecedores() async {
    try {
      List<String> fornecedores =
          await _fornecedorRepository.getNomesFornecedores();
      setState(() {
        _fornecedores = fornecedores; // Atualiza a lista de fornecedores
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar fornecedores: $e')),
      );
    }
  }

  Future<void> _cadastrarMaterial() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        // Determina o tipo do material
        final idTipo = await _tipoRepository.getIdByTipo(_tipo!);

        // Determina o fornecedor do material
        final idFornecedor =
            await _fornecedorRepository.getIdByForenecedor(_fornecedor!);

        // Cria o objeto Material
        final material = MaterialModel(
          idMaterial: null, // ID gerado automaticamente
          codigo: _codigoController.text,
          nome: _nomeController.text,
          quantidade: int.parse(_quantidadeController.text),
          validade: _vencimentoController.text.isNotEmpty
              ? _vencimentoController.text
              : null, // Pode ser nulo se não aplicável
          local: _localController.text,
          idtipo: idTipo!,
          idfornecedor: idFornecedor!,
          entrada: _dataEntradaController.text,
        );

        // Insere o material no banco de dados
        await _materialRepository.insertMaterial(material);

        // Exibe mensagem de sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Material cadastrado com sucesso!')),
        );

        // Limpa os campos do formulário
        _codigoController.clear();
        _nomeController.clear();
        _quantidadeController.clear();
        _localController.clear();
        _fornecedorCustomController.clear();
        _tipoCustomController.clear();
        _dataEntradaController.clear();
        _vencimentoController.clear();
        setState(() {
          _tipo = null;
          _fornecedor = null;
        });
      } catch (e, stackTrace) {
        debugPrint(
            'Erro: $e\n$stackTrace'); // Para ver mais detalhes no console
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar fornecedores: $e')),
        );
      }
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
                TextFormField(
                  controller: _localController,
                  decoration: inputDecoration.copyWith(labelText: 'Local'),
                  keyboardType: TextInputType.text,
                  style: const TextStyle(color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O local é obrigatória';
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
                // Dropdown para selecionar fornecedor, agora com lista dinâmica
                DropdownButtonFormField<String>(
                  value: _fornecedor,
                  decoration: inputDecoration.copyWith(labelText: 'Fornecedor'),
                  items: _fornecedores
                      .map((fornecedor) => DropdownMenuItem(
                            value: fornecedor, // Ou outro campo identificador
                            child: Text(
                              fornecedor, // Exibe o nome do fornecedor
                              style: const TextStyle(color: Colors.black),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _fornecedor = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O fornecedor é obrigatório';
                    }
                    return null;
                  },
                ),

                // Campo personalizado para fornecedor se a opção "Outro" for selecionada
                if (_fornecedor == "Outro")
                  TextFormField(
                    controller: _fornecedorCustomController,
                    decoration: inputDecoration.copyWith(
                        labelText: 'Descreva o Fornecedor'),
                    style: const TextStyle(color: Colors.black),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Descreva o fornecedor';
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
                const SizedBox(height: 16),
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
