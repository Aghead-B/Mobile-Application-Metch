import 'package:metch/domain/models/match.dart';

abstract class MatchRepository{
  const MatchRepository();

  Future<Match> searchMatch(int id);
}