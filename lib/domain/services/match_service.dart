import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:metch/domain/api.constants.dart';
import 'package:metch/domain/models/match.dart';
import 'package:metch/domain/repositories/match_repository.dart';
import 'package:http/http.dart' as http;

class MatchService implements MatchRepository {
  @override
  Future<Match> searchMatch(int id) async {
    final response = await http.get(Uri.parse('$api_url/Metch/$id'));

    if (response.statusCode == 200) {
      Match newMatch = Match.fromJson(jsonDecode(response.body));
      return newMatch;
    } else {
      throw Exception('Failed to load match');
    }
  }
}
