import 'dart:convert';
import 'package:get/get.dart';
import 'package:phishing_quest/app/data/enumerators/storage_keys.enum.dart';
import 'package:phishing_quest/app/data/enumerators/user_role.enum.dart';
import 'package:phishing_quest/app/data/mock/mock_data.dart';
import 'package:phishing_quest/app/data/models/user.model.dart';
import 'package:phishing_quest/app/data/storage/memory_storage.dart';

class AuthService extends GetxService {
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final RxBool isLoggedIn = false.obs;

  bool get isAdmin => currentUser.value?.isAdmin ?? false;

  final _tokenStore = MemoryStore(StorageKeys.USER_TOKEN);
  final _profileStore = MemoryStore(StorageKeys.PROFILE_INFO);

  Future<AuthService> init() async {
    await checkAuth();
    return this;
  }

  Future<void> checkAuth() async {
    final token = _tokenStore.read<String>();
    if (token != null && token.isNotEmpty) {
      final profileJson = _profileStore.read<String>();
      if (profileJson != null) {
        try {
          final map = jsonDecode(profileJson) as Map<String, dynamic>;
          currentUser.value = UserModel.fromJson(map);
          isLoggedIn.value = true;
          return;
        } catch (_) {}
      }
      // Token exists but no profile — use mock
      currentUser.value = MockData.currentUser;
      isLoggedIn.value = true;
    }
  }

  Future<void> login({
    required String token,
    Map<String, dynamic>? userData,
  }) async {
    await _tokenStore.write(token);

    if (userData != null) {
      // Check for role in response, default to player
      if (!userData.containsKey('role')) {
        userData['role'] = 'player';
      }
      currentUser.value = UserModel.fromJson(userData);
      await _profileStore.write(jsonEncode(userData));
    } else {
      // Mock user data
      currentUser.value = MockData.currentUser;
      await _profileStore.write(jsonEncode(MockData.currentUser.toJson()));
    }

    isLoggedIn.value = true;
  }

  Future<void> loginAsMockAdmin() async {
    await _tokenStore.write('mock-admin-token');
    currentUser.value = MockData.adminUser;
    await _profileStore.write(jsonEncode(MockData.adminUser.toJson()));
    isLoggedIn.value = true;
  }

  void setRole(UserRole role) {
    if (currentUser.value != null) {
      currentUser.value = UserModel(
        id: currentUser.value!.id,
        username: currentUser.value!.username,
        email: currentUser.value!.email,
        role: role,
        score: currentUser.value!.score,
        avatarUrl: currentUser.value!.avatarUrl,
        createdAt: currentUser.value!.createdAt,
      );
    }
  }

  Future<void> logout() async {
    await _tokenStore.remove();
    await _profileStore.remove();
    currentUser.value = null;
    isLoggedIn.value = false;
  }
}
