import 'dart:io';
import 'dart:typed_data';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'dart:convert';

import 'usecases/convert_ogg_to_opus_usecase.dart';

class ServeHandler {
  Handler get handler {
    final router = Router();

    router.post("/audio", (Request req) async {
      final audio = await req.read().toList();
      if (audio.isNotEmpty) {
        final result = await ConvertOggToOpusUsecase().call(Uint8List.fromList(audio.first));
        return Response.ok(result, headers: {'Content-Type': "audio/opus"});
      } else {
        return Response.forbidden("Erro: áudio nulo");
      }
    });

    return router;
  }
}
