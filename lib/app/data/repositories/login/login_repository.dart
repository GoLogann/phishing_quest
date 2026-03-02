import 'package:phishing_quest/app/data/repositories/request_repository.dart';
import 'login_repository.interface.dart';

final class LoginRepository extends RequestRepository implements ILoginRepository {
  static const String loginUrlProduction = '/users/login';

  @override
  Future<ValidResponse> login({
    required String email,
    required String password,
  }) async {
    final url = apiHelpers.buildUrl(url: loginUrlProduction);

    final body = {
      'email': email,
      'password': password,
    };

    try {
      final response = await client.post(url, body, headers: {});

      // final invalidResponse = isValidResponse(response.data as Response.);
      // if (!invalidResponse.valid) {
      //   return invalidResponse;
      // }
      return (valid: true, reason: null, data: null);
    } catch (_) {
      return (valid: false, reason: 'Erro interno durante a requisição', data: null);
    }
  }
}
