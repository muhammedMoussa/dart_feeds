import 'package:dart_reads/dart_reads.dart';

class Read extends ManagedObject<_Read> implements _Read {
  String get detail => '$title by $author';
}
class _Read {
  @primaryKey
  int id;

  @Column(unique: true)
  String title;

  @Column()
  String author;

  @Column()
  int year;
}