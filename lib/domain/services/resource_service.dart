import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:metch/domain/api.constants.dart';
import 'package:metch/domain/models/resource.dart';
import 'package:metch/domain/repositories/ResourceRepository.dart';
import 'package:http/http.dart' as http;

class ResourceService implements ResourceRepository {
  @override
  Future<List<Resource>> getResource(int id) async {
    final response = await http.get(Uri.parse('$api_url?ids'));

    if (response.statusCode == 200) {
      List<Resource> resources = [];
      List<dynamic> resourcesResponse = jsonDecode(response.body)['Resources'];

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