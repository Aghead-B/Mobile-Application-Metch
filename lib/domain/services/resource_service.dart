import 'package:metch/domain/api.constants.dart';
import 'package:metch/domain/models/resource.dart';
import 'package:metch/domain/repositories/ResourceRepository.dart';
import 'package:http/http.dart' as http;

class ResourceService implements ResourceRepository {
  @override
  Future<List<Resource>> getResource(int id) async {
    final response = await http.post(Uri.parse('$api_url?ids'));
    // TODO: implement getResource
    throw UnimplementedError();
  }

}