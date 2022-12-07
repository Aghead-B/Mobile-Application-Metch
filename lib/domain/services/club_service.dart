import 'dart:convert';
import 'package:metch/domain/api.constants.dart';
import 'package:metch/domain/models/club.dart';
import 'package:metch/domain/repositories/club_repository.dart';
import 'package:http/http.dart' as http;

class ClubService implements ClubRepository {
  @override
  Future<List<Club>> searchClubs(String name) async {
    final response =
    await http.get(Uri.parse('$api_url/Club/?sportid=9&q=$name'));

    if (response.statusCode == 200) {
      List<Club> finalClubList = [];
      List<dynamic> clubs = jsonDecode(response.body)['Clubs'];

      var it = clubs.iterator;

      while (it.moveNext()) {
        finalClubList.add(Club(
            id: it.current['Id'].toString(),
            name: it.current['Name'].toString()));
      }

      return finalClubList;
    } else {
      throw Exception('Failed to load club(s)');
    }
  }
}
