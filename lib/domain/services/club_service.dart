import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:metch/domain/models/club.dart';
import 'package:metch/domain/repositories/club_repository.dart';


class ClubService implements ClubRepository{
  @override
  Future<List<Club>> searchClubs(String name) async {
    debugPrint("BANAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAN");
    final response = await http
        .get(Uri.parse('https://cdn2.thecatapi.com/images/ebv.jpg'));


    if (response.statusCode == 200) {
      Set body = jsonDecode(response.body);
      var it = body.iterator;
      while (it.moveNext()) {
        debugPrint(it.current);
      }
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return [];
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }

  }

}