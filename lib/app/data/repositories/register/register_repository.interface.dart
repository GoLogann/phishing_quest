abstract interface class IRegisterRepository {
  Future<dynamic> register({
    required String username,
    required String password,
    required String email,
  });
}
