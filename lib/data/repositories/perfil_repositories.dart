import 'package:app_estoque_limpeza/core/database_helper.dart';
import 'package:app_estoque_limpeza/data/model/perfil_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class PerfilRepository {
  Future<void> insertPerfil(Perfil perfil) async {
    final db = await DatabaseHelper.initDb();
    await db.insert(
      'perfil',
      perfil.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Perfil>> getPerfis() async {
    final db = await DatabaseHelper.initDb();
    final List<Map<String, Object?>> perfilMaps = await db.query('perfil');
    return perfilMaps.map((map) {
      return Perfil(
        idperfil: map['idperfil'] as int?,
        perfil: map['perfil'] as String,
      );
    }).toList();
  }

  Future<void> updatePerfil(Perfil perfil) async {
    final db = await DatabaseHelper.initDb();
    await db.update(
      'perfil',
      perfil.toMap(),
      where: 'idperfil = ?',
      whereArgs: [perfil.idperfil],
    );
  }

  Future<void> deletePerfil(int id) async {
    final db = await DatabaseHelper.initDb();
    await db.delete(
      'perfil',
      where: 'idperfil = ?',
      whereArgs: [id],
    );
  }
}
