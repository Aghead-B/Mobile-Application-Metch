import 'package:metch/domain/models/share_match.dart';

abstract class MatchRepository{
  const MatchRepository();

  Future<SharedMatch> getMatch(int id);
}