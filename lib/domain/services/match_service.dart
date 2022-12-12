import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:metch/domain/api.constants.dart';
import 'package:http/http.dart' as http;
import 'package:metch/domain/models/match.dart';

class MatchService {
  Future<MatchCreated> postMatch(Match match) async {
    final response = await http.post(
        Uri.parse('$api_url/Metch/'
            '?clubid=${match.clubid}&sportid=${match.sportid}&levelmin=${match.levelmin}&planned=${match.planned}'
            '&duration=${match.duration}&spots=${match.spots}&levelmax=${match.levelmax}&court=${match.court}')
    );

      if (response.statusCode == 200) {
        debugPrint(jsonDecode(response.body)['Id'].toString());
        return MatchCreated(id: jsonDecode(response.body)['Id']);
      } else {
        throw Exception('Failed to create match');
      }
    }
  }



