import 'dart:io';

import 'dart_reads.dart';
import 'package:dart_reads/controller/reads_controller.dart';

class DartReadsChannel extends ApplicationChannel {
  ManagedContext context;

  @override
  Future prepare() async {

    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final store = PostgreSQLPersistentStore.fromConnectionInfo(
      'muhammed',
      'muhammed',
      'localhost',
      5432,
      'dart_reads'
      );

    context = ManagedContext(dataModel, store);
  }
  @override
  Controller get entryPoint {
    final router = Router();
    router
      ..route("/reads/[:id]").link(() => ReadsController(context))
      //
      ..route("/")
      .linkFunction((request) => Response.ok('Hi')..contentType = ContentType.html)
      //
      ..route("api")
      .linkFunction((req) async {
        final file = await File("client.html").readAsString();
        return Response.ok(file)..contentType = ContentType.html;
      });

    return router;
  }
}