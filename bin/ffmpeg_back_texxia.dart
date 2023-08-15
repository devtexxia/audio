// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'dart:convert';
import 'dart:io' as io;
import 'services/server_handler.dart';
import 'package:dotenv/dotenv.dart';

void main() async {
  var env = DotEnv(includePlatformEnvironment: true)..load();
  String _ip = env["IP"].toString();
  int _portHttp = int.parse(env["PORTHTTP"] ?? "0");

  print("ip: $_ip, http: $_portHttp, ");
  var _server = ServeHandler();
  final server = await shelf_io.serve(_server.handler, "0.0.0.0", 1315);
  print("Nosso servidor foi iniciado http://localhost:$_portHttp");
}
