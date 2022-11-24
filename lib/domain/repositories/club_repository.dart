import 'package:metch/domain/models/club.dart';

abstract class ClubRepository{
  const ClubRepository();

  Future<List<Club>> searchClubs(String name);
}