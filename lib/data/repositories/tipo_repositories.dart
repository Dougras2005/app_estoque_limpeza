import 'package:app_estoque_limpeza/core/database_helper.dart';
import 'package:app_estoque_limpeza/data/model/tipo_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class TipoRepository {
  Future<void> insertTipo(Tipo tipo) async {
    final db = await DatabaseHelper.initDb();
    await db.insert(
      'tipo',
      tipo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Tipo>> getTipos() async {
    final db = await DatabaseHelper.initDb();
    final List<Map<String, Object?>> tipoMaps = await db.query('tipo');
    return tipoMaps.map((map) {
      return Tipo(
        idtipo: map['idtipo'] as int?,
        tipo: map['tipo'] as String,
      );
    }).toList();
  }

  Future<void> updateTipo(Tipo tipo) async {
    final db = await DatabaseHelper.initDb();
    await db.update(
      'tipo',
      tipo.toMap(),
      where: 'idtipo = ?',
      whereArgs: [tipo.idtipo],
    );
  }

  Future<void> deleteTipo(int id) async {
    final db = await DatabaseHelper.initDb();
    await db.delete(
      'tipo',
      where: 'idtipo = ?',
      whereArgs: [id],
    );
  }
}
