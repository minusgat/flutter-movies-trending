import 'dart:convert';

import 'unauthorised_exception.dart';
import 'package:http/http.dart';

import 'api_constants.dart';

class ApiClient {
  final Client _client;

  ApiClient(this._client);

  dynamic get(String path,
      {Map<dynamic, dynamic>? params, String? token}) async {
    final response = await _client.get(
      getPath(path, params),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${token ?? ApiConstants.movie_data_base_api_token}',
      },
    );

    if (response.statusCode == 200)
      return json.decode(response.body);
    else if (response.statusCode == 401)
      throw UnauthorisedException();
    else
      throw Exception(response.reasonPhrase);
  }

  Uri getPath(String path, Map<dynamic, dynamic>? params) {
    var paramsString = '';
    var parsedUri;
    if (params?.isNotEmpty ?? false) {
      params?.forEach((key, value) {
        paramsString += '&$key=$value';
      });
    }

    parsedUri = Uri.parse(
        '${ApiConstants.movie_data_base_base_url}$path?${paramsString.substring(1)}');

    return parsedUri;
  }
}
