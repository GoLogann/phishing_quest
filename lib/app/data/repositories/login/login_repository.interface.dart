abstract interface class ILoginRepository {
  Future<dynamic> login({required String email, required String password});
}
