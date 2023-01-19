import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:metch/domain/api.constants.dart';
import 'package:http/http.dart' as http;
import 'package:metch/domain/models/match.dart';
import '../models/share_match.dart';
import 'package:metch/globals.dart' as globals;

class MatchService {
  Future<SharedMatch> getMatch(int id) async {
    final response = await http.get(Uri.parse('$api_url_v2/Metch/$id?Sid=${globals.Sid}'));

    // var data = '{"Id":1248401,"SportId":109,"Created":"2023-01-18T09:18:57.8368585Z","Planned":"2023-01-18T10:14:24.077Z","PlannedShort":"","OwnerId":131885,"Court":0,"LevelMin":3,"LevelMax":7,"Duration":90,"Spots":2,"State":8,"Players":[{"Id":131885,"Name":"Alae el Hani","Short":"Alae"},{"Id":0,"Name":null,"Short":null},null,null],"Club":{"Id":2188,"Name":"Metzpoint","City":"Veldhoven","Address":"Peter Zuidlaan 40","URL":"http://www.metzpoint.nl"}}';


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

  Future<String> cancelMatch(int matchId) async {
    debugPrint("geit");
    final response =
        await http.post(Uri.parse('$api_url/Metch/$matchId/?Sid=a6a02fee-f041-4ae1-b2b9-16f223179f0b&state=4'));

    if (response.statusCode == 200) {
      debugPrint(response.statusCode.toString());
      return "Match canceled successfully";
    } else {
      throw Exception('Failed to cancel match');
    }
  }
}
