import 'package:phishing_quest/app/data/models/ranking_entry.model.dart';
import 'package:phishing_quest/app/data/models/user_stats.model.dart';

abstract class IRankingRepository {
  Future<List<RankingEntryModel>> getGlobalRanking();
  Future<int> getUserRank(String userId);
  Future<UserStatsModel> getUserStats(String userId);
}
