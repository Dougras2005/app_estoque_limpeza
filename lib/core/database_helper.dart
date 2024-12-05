import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Future<Database> initDb() async {
    // Inicializa a interface FFI para SQLite
    sqfliteFfiInit();

    // Caminho do banco de dados
    final databasePath = await databaseFactoryFfi.getDatabasesPath();
    final path = join(databasePath, 'mydb.db');

    // Abre ou cria o banco de dados
    return await databaseFactoryFfi.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          // Criação das tabelas
          await db.execute('''
            CREATE TABLE tipo (
              idtipo INTEGER PRIMARY KEY,
              tipo TEXT NOT NULL
            );
          ''');

          await db.execute('''
            CREATE TABLE fornecedor (
              idfornecedor INTEGER PRIMARY KEY,
              nome TEXT NOT NULL,
              endereco TEXT NOT NULL,
              telefone INTEGER NOT NULL
            );
          ''');

          await db.execute('''
            CREATE TABLE Material (
              idMaterial INTEGER PRIMARY KEY AUTOINCREMENT,
              Codigo TEXT NOT NULL UNIQUE,
              Nome TEXT NOT NULL,
              Quantidade INTEGER NOT NULL,
              entrada TEXT NOT NULL,
              baixa TEXT NOT NULL, 
              Validade TEXT,
              Local TEXT NOT NULL,
              idtipo INTEGER NOT NULL,
              idfornecedor INTEGER,
              entrada TEXT NOT NULL,
              FOREIGN KEY (idtipo) REFERENCES tipo(idtipo),
              FOREIGN KEY (idfornecedor) REFERENCES fornecedor(idfornecedor)
            );
          ''');

          await db.execute('''
            CREATE TABLE usuario (
              idusuario INTEGER PRIMARY KEY,
              matricula TEXT NOT NULL UNIQUE,
              nome TEXT NOT NULL,
              idtelefone INTEGER NOT NULL,
              email TEXT NOT NULL UNIQUE,
              idperfil INTEGER NOT NULL
            );
          ''');

          await db.execute('''
            CREATE TABLE telefone (
              idtelefone INTEGER PRIMARY KEY AUTOINCREMENT,
              telefone REAL NOT NULL UNIQUE
            );
          ''');

          await db.execute('''
            CREATE TABLE perfil (
              idperfil INTEGER PRIMARY KEY AUTOINCREMENT,
              perfil TEXT NOT NULL
            );
          ''');

          await db.execute('''
            CREATE TABLE movimentacao (
              idmovimentacao INTEGER PRIMARY KEY,
              saida TEXT NOT NULL,
              idmaterial INTEGER NOT NULL,
              idusuario INTEGER NOT NULL,
              FOREIGN KEY (idmaterial) REFERENCES Material(idMaterial),
              FOREIGN KEY (idusuario) REFERENCES usuario(idusuario)
            );
          ''');
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          // Adicione lógica de upgrade se necessário
        },
      ),
    );
  }
}
