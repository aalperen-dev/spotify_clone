import 'package:http/http.dart' as http;
import 'package:spotify/core/constants/server_constants.dart';

class HomeRepository {
  Future<void> uploadSong() async {
    final request = http.MultipartRequest(
        'POST', Uri.parse('${ServerConstants.serverUrl}/song/upload'));

    request
      ..files.addAll([
        await http.MultipartFile.fromPath('song', 'value'),
        await http.MultipartFile.fromPath('thumbnail', 'value'),
      ])
      ..fields.addAll(
          {'artist': 'Test', 'song_name': 'Deneme', 'hex_code': 'FFFFFF'})
      ..headers.addAll({'x-auth-token': 'token'});

    final res = await request.send();
  }
}
