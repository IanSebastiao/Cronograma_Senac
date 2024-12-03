import 'package:sqflite/sqflite.dart';
import '../../core/database_helper.dart';
import '../models/cursos_model.dart';

class CursosRepository {
  Future<void> insertCurso(Cursos curso) async {
    final db = await DatabaseHelper.initDb();
    await db.insert(
      'Cursos',
      curso.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Cursos>> getCursos() async {
    final db = await DatabaseHelper.initDb();
    final List<Map<String, Object?>> cursoMaps = await db.query('Cursos');
    return cursoMaps.map((map) {
      return Cursos(
        idCursos: map['idCursos'] as int?,
        nomeCurso: map['nome_curso'] as String,
        cargahoraria: map['cargahoraria'] as int,
      );
    }).toList();
  }

  Future<void> updateCurso(Cursos curso) async {
    final db = await DatabaseHelper.initDb();
    await db.update(
      'Cursos',
      curso.toMap(),
      where: 'idCursos = ?',
      whereArgs: [curso.idCursos],
    );
  }

  Future<void> deleteCurso(int id) async {
    final db = await DatabaseHelper.initDb();
    await db.delete(
      'Cursos',
      where: 'idCursos = ?',
      whereArgs: [id],
    );
  }
}