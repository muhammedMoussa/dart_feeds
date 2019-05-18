import 'dart:async';
import 'dart:developer';
import 'package:aqueduct/aqueduct.dart';
import 'package:dart_reads/dart_reads.dart';
import '../models/read.dart';

List<Read> reads = [
  Read()
    ..readFromMap({
    'title': 'Head First Design Patterns',
    'author': 'Eric Freeman',
    'year': 2004
  }),
  Read()
    ..readFromMap({
    'title': 'Clean Code: A handbook of Agile Software Craftsmanship',
    'author': 'Robert C. Martin',
    'year': 2008
  }),
  Read()
    ..readFromMap({
    'title': 'Code Complete: A Practical Handbook of Software Construction',
    'author': 'Steve McConnell',
    'year': 2004
  }),
];

class ReadsController extends ResourceController {
  @Operation.get()
  Future<Response> getAllReads() async {
    return Response.ok(reads);
  }

@Operation.get('id')
  Future<Response> getAllReadById(@Bind.path('id') int id) async {
    if (id < 0 || id > reads.length -1) {
      return Response.notFound(body: 'NOT FOUND :(');
    }

    return Response.ok(reads[id]);
  }

  @Operation.post()
  Future<Response> createRead(@Bind.body() Read body) async {
    reads.add(body);
    return Response.ok('Created! ==> $body');
  }

  @Operation.put('id')
  Future<Response> updateRead(@Bind.path('id') int id, @Bind.body() Read body) async {
    if (id < 0 || id > reads.length -1) {
      return Response.notFound(body: 'NOT FOUND :(');
    }
    reads[id] = body;
    return Response.ok('UPDATED!!');
  }

  @Operation.delete('id')
  Future<Response> deleteRead(@Bind.path('id') int id) async {
    if (id < 0 || id > reads.length -1) {
      return Response.notFound(body: 'NOT FOUND :(');
    }

    reads.removeAt(id);
    return Response.ok('DELETED!!');
  }
}