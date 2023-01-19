import 'dart:convert';
import 'package:metch/domain/api.constants.dart';
import 'package:http/http.dart' as http;
import 'package:metch/domain/models/match.dart';
import '../models/share_match.dart';
import 'package:metch/globals.dart' as globals;

class MatchService {
  Future<SharedMatch> getMatch(int id) async {
    final response = await http.get(Uri.parse('$api_url_v2/Metch/$id'));

    if (response.statusCode == 200) {
      SharedMatch newMatch = SharedMatch.fromJson(jsonDecode(response.body));
      return newMatch;
    } else {
      throw Exception('Failed to load match');
    }
  }

  Future<MatchCreated> postMatch(Match match) async {
    final response = await http.post(Uri.parse('$api_url_v2/Metch/'
        '?clubid=${match.clubId}&sportid=${match.sportId}&levelmin=${match.levelMin}&planned=${match.planned}'
        '&duration=${match.duration}&spots=${match.spots}&levelmax=${match.levelMax}&court=${match.court}&Sid=${globals.Sid}'));

    if (response.statusCode == 200) {
      return MatchCreated(
          id: int.parse(jsonDecode(response.body)['Id'].toString()));
    } else {
      throw Exception('Failed to create match');
    }
  }

  removePlayer(int matchId, int spot) async {
    final response = await http.post(
        Uri.parse('$api_url_v2/Metch/$matchId/?spot=$spot&Sid=${globals.Sid}'));
    if (response.statusCode != 200) {
      throw Exception('Failed to remove player');
    }
  }

  postGuestPlayer(int matchId, int spot) async {
    const GUEST_USER = 0;
    final response = await http.post(Uri.parse(
        '$api_url_v2/Metch/$matchId/?spot=$spot&userId=$GUEST_USER&Sid=${globals.Sid}'));
    if (response.statusCode != 200) {
      throw Exception('Failed to remove player');
    }
  }
}
