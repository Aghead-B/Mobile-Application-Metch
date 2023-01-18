import 'dart:convert';
import 'package:metch/domain/api.constants.dart';
import 'package:http/http.dart' as http;
import 'package:metch/domain/models/match.dart';
import '../models/share_match.dart';
import 'package:metch/globals.dart' as globals;

class MatchService {
  Future<SharedMatch> getMatch(int id) async {
    final response = await http.get(Uri.parse('$api_url_v2/Metch/$id?Sid=${globals.Sid}'));

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

    print(globals.Sid);
    print(globals.userId);
    if (response.statusCode == 200) {
      return MatchCreated(
          id: int.parse(jsonDecode(response.body)['Id'].toString()));
    } else {
      throw Exception('Failed to create match');
    }
  }
}
