import 'dart:async';
import 'package:aqueduct/aqueduct.dart';

class Migration1 extends Migration {
  @override
  Future upgrade() async {
   		database.createTable(SchemaTable("_Read", [SchemaColumn("id", ManagedPropertyType.bigInteger, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("title", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: true),SchemaColumn("author", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("year", ManagedPropertyType.integer, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false)]));
  }

  @override
  Future downgrade() async {}

  @override
  Future seed() async {
    final List<Map> reads = [
      {
        'title': 'Test Title 1',
        'author': 'Test Autor 1',
        'year': 200
      },
      {
        'title': 'Test Title 2',
        'author': 'Test Autor 2',
        'year': 2001
      },
      {
        'title': 'Test Title 3',
        'author': 'Test Autor 3',
        'year': 2003
      }
    ];

    for (final read in reads) {
      await database.store.execute(
        'INSERT INTO _Read (title, author, year) VALUES (@title, @author, @year)',
        substitutionValues: {
          'title': read['title'],
          'author': read['author'],
          'year': read['year']
        }
      );
    }
  }
}
