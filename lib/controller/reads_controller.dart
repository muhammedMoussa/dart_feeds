import 'dart:async';
import 'dart:developer';
import 'package:aqueduct/aqueduct.dart';
import 'package:dart_reads/dart_reads.dart';
import '../models/read.dart';

class ReadsController extends ResourceController {
  ReadsController(this.context);
  ManagedContext context;

  @Operation.get()
  Future<Response> getAllReads() async {
    final readQuery = Query<Read>(context);
    return Response.ok(await readQuery.fetch());
  }

@Operation.get('id')
  Future<Response> getAllReadById(@Bind.path('id') int id) async {
  final query = Query<Read>(context)
    ..where((read) => read.id).equalTo(id);

  final read = await query.fetchOne();

  if (read == null) {
    return Response.notFound(body: 'NOT FOUND :(');
  }

  return Response.ok(read);
}

  @Operation.post()
  Future<Response> createRead(@Bind.body() Read body) async {
    final query = Query<Read>(context)..values = body;
    final insert = await query.insert();

    return Response.ok('Created! ==> $insert');
  }

  @Operation.put('id')
  Future<Response> updateRead(@Bind.path('id') int id, @Bind.body() Read body) async {
    final readQuery = Query<Read>(context)
      ..values = body
      ..where((read) => read.id).equalTo(id);

    final updatedQuery = await readQuery.updateOne();

    if (updatedQuery == null) {
      return Response.notFound(body: 'Item not found.');
    }

    return Response.ok(updatedQuery);
  }

  @Operation.delete('id')
  Future<Response> deletedRead(@Bind.path('id') int id) async {
    final readQuery = Query<Read>(context)
      ..where((read) => read.id).equalTo(id);

    final int deleteCount = await readQuery.delete();

    if (deleteCount == 0) {
      return Response.notFound(body: 'Item not found.');
    }
    return Response.ok('Deleted $deleteCount items.');
  }
}