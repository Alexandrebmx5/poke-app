import 'package:http/http.dart' show Client, Response;
import 'package:poke_app/src/core/framework/utils/constants.dart';

class ClientService {
  ClientService();

  final Client client = Client();

  Future<Response> get(String? url) async {
    return await client.get(
      Uri.parse('$baseURL${url ?? ''}'),
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future<Response> getTypes(String? url) async {
    return await client.get(
      Uri.parse('$baseTypesURL${url ?? ''}'),
      headers: {'Content-Type': 'application/json'},
    );
  }
}