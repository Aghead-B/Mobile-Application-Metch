import 'dart:convert';
import 'package:metch/domain/api.constants.dart';
import 'package:http/http.dart' as http;
import 'package:metch/domain/models/match.dart';

import '../models/share_match.dart';

class MatchService {
  Future<SharedMatch> getMatch(int id) async {
    final response = await http.get(Uri.parse('$api_url/Metch/$id'));

    if (response.statusCode == 200) {
      SharedMatch newMatch = SharedMatch.fromJson(jsonDecode(response.body));
      return newMatch;
    } else {
      throw Exception('Failed to load match');
    }
  }

  Future<MatchCreated> postMatch(Match match) async {
    final response = await http.post(Uri.parse('$api_url/Metch/'
        '?clubid=${match.clubid}&sportid=${match.sportid}&levelmin=${match.levelmin}&planned=${match.planned}'
        '&duration=${match.duration}&spots=${match.spots}&levelmax=${match.levelmax}&court=${match.court}'));

    if (response.statusCode == 200) {
      return MatchCreated(
          id: int.parse(jsonDecode(response.body)['Id'].toString()));
    } else {
      throw Exception('Failed to create match');
    }
  }
}
