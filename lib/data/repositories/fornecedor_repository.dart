import 'package:app_estoque_limpeza/core/database_helper.dart';
import 'package:app_estoque_limpeza/data/model/fornecedor_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class FornecedorRepository {
  Future<void> insertFornecedor(Fornecedor fornecedor) async {
    final db = await DatabaseHelper.initDb();
    await db.insert(
      'fornecedor',
      fornecedor.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Fornecedor>> getFornecedores() async {
    final db = await DatabaseHelper.initDb();
    final List<Map<String, Object?>> fornecedorMaps =
        await db.query('fornecedor');
    return fornecedorMaps.map((map) {
      return Fornecedor(
        idfornecedor: map['idfornecedor'] as int?,
        nome: map['nome'] as String,
        endereco: map['endereco'] as String,
        telefone: map['telefone'] as String,
      );
    }).toList();
  }

  Future<void> updateFornecedor(Fornecedor fornecedor) async {
    final db = await DatabaseHelper.initDb();
    await db.update(
      'fornecedor',
      fornecedor.toMap(),
      where: 'idfornecedor = ?',
      whereArgs: [fornecedor.idfornecedor],
    );
  }

  Future<void> deleteFornecedor(int id) async {
    final db = await DatabaseHelper.initDb();
    await db.delete(
      'fornecedor',
      where: 'idfornecedor = ?',
      whereArgs: [id],
    );
  }
}
