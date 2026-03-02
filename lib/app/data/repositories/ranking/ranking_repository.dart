import 'package:phishing_quest/app/data/mock/mock_data.dart';
import 'package:phishing_quest/app/data/models/ranking_entry.model.dart';
import 'package:phishing_quest/app/data/models/user_stats.model.dart';
import 'package:phishing_quest/app/data/repositories/ranking/ranking_repository.interface.dart';

class RankingRepository implements IRankingRepository {
  @override
  Future<List<RankingEntryModel>> getGlobalRanking() async {
    // TODO: Replace with API call when endpoint is available
    await Future.delayed(const Duration(milliseconds: 500));
    return MockData.ranking;
  }

  @override
  Future<int> getUserRank(String userId) async {
    final ranking = await getGlobalRanking();
    final entry = ranking.where((e) => e.userId == userId).firstOrNull;
    return entry?.position ?? ranking.length + 1;
  }

  @override
  Future<UserStatsModel> getUserStats(String userId) async {
    // TODO: Replace with API call when endpoint is available
    await Future.delayed(const Duration(milliseconds: 300));
    return MockData.userStats;
  }
}
