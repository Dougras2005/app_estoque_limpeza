import 'package:app_estoque_limpeza/data/model/fornecedor_model.dart';
import 'package:app_estoque_limpeza/data/repositories/fornecedor_repository.dart';
import 'package:flutter/foundation.dart';

class FornecedorViewModel extends ChangeNotifier {
  final FornecedorRepository _fornecedorRepository;

  // Lista para armazenar os fornecedores
  List<Fornecedor> _fornecedores = [];

  // Getter para acessar os fornecedores
  List<Fornecedor> get fornecedores => _fornecedores;

  // Construtor para inicializar o repositório
  FornecedorViewModel(this._fornecedorRepository);

  // Método para carregar os fornecedores
  Future<void> loadFornecedores() async {
    _fornecedores = await _fornecedorRepository.getFornecedores();
    notifyListeners(); // Notificando a UI para se atualizar com os novos dados
  }

  // Método para adicionar um novo fornecedor
  Future<void> addFornecedor(Fornecedor fornecedor) async {
    await _fornecedorRepository.insertFornecedor(fornecedor);
    await loadFornecedores(); // Recarregar a lista de fornecedores após a inserção
  }

  // Método para atualizar um fornecedor existente
  Future<void> updateFornecedor(Fornecedor fornecedor) async {
    await _fornecedorRepository.updateFornecedor(fornecedor);
    await loadFornecedores(); // Recarregar a lista de fornecedores após a atualização
  }

  // Método para deletar um fornecedor
  Future<void> deleteFornecedor(int id) async {
    await _fornecedorRepository.deleteFornecedor(id);
    await loadFornecedores(); // Recarregar a lista de fornecedores após a exclusão
  }
}
