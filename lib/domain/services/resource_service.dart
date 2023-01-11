import 'dart:convert';
import 'package:metch/domain/api.constants.dart';
import 'package:metch/domain/models/resource.dart';
import 'package:metch/domain/repositories/resource_repository.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class ResourceService implements ResourceRepository {
  @override
  Future<List<Resource>> getResource(List<int> ids) async {
    Dio dio = Dio();

    var idsString = ids
        .toString()
        .replaceAll(RegExp(r'[\[\]]'), '')
        .replaceAll(RegExp(r'\s+'), '');

    dio.interceptors
        .add(DioCacheManager(CacheConfig(baseUrl: base_url)).interceptor);

    final response = await dio.get('$api_url/Resource/?ids=$idsString',
        options: buildCacheOptions(const Duration(days: 7),
            maxStale: const Duration(days: 10)));

    if (response.statusCode == 200) {
      List<Resource> resources = [];
      List<dynamic> resourcesResponse =
          jsonDecode(response.toString())['Resources'];

      var it = resourcesResponse.iterator;

      while (it.moveNext()) {
        resources.add(Resource(
            id: it.current['Id'].toString(),
            value: it.current['Value'].toString()));
      }

      return resources;
    } else {
      throw Exception('Failed to load resource');
    }
  }
}
