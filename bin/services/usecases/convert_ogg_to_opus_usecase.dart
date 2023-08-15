import 'dart:io';
import 'dart:typed_data';

class ConvertOggToOpusUsecase {
  Future<Uint8List> call(Uint8List audio) async {
    final String uniqueFileName = 'audio_${DateTime.now().millisecondsSinceEpoch}.ogg';
    final String outputFileName = 'audio_${DateTime.now().millisecondsSinceEpoch}.opus';
    final file = File(uniqueFileName);
    await file.writeAsBytes(audio);

    final processResult = await Process.run('ffmpeg', ['-i', file.path, '-c:a', 'libopus', '-b:a', '128k', outputFileName]);
    final output = File(outputFileName);
    final bytes = await output.readAsBytes();
    await file.delete(); // Deleta o arquivo de entrada
    await output.delete(); // Deleta o arquivo de saída

    if (processResult.exitCode != 0) {
      throw Exception("Erro ao converter áudio.");
    }

    return bytes;
  }
}
