import 'package:tugas_api_paml/app/models/user.dart';
import 'package:vania/vania.dart';

class AuthController extends Controller {
  Future<Response> login(Request request) async {
    try {
      final email = request.input('email');
      final password = request.input('password');

      if (email == null || password == null) {
        return Response.json({
          'success': false,
          'message': 'Masukkan email dan password',
        });
      }

      final user = await User().query().where('email', '=', email).first();
      if (user == null) {
        return Response.json({
          'success': false,
          'message': 'Email atau Password tidak sesuai',
        });
      }

      final isPasswordMatch = Hash().verify(password, user['password']);
      if (!isPasswordMatch) {
        return Response.json(
            {'success': false, 'message': 'Email atau Password tidak sesuai'});
      }

      final token = await Auth()
          .login(user)
          .createToken(expiresIn: Duration(days: 7), withRefreshToken: true);

      return Response.json({
        'success': true,
        'message': 'Berhasil Login',
        'data': {
          'user': user,
          'token': token,
        }
      });
    } catch (e) {
      return Response.json(
          {'success': false, 'message': 'Gagal Login', 'error': e.toString()});
    }
  }

  Future<Response> register(Request request) async {
    try {
      final name = request.input('name');
      final email = request.input('email');
      final password = request.input('password');

      if (name == null || email == null || password == null) {
        return Response.json({
          'success': false,
          'message': 'Masukkan nama, email dan password',
        });
      }

      var isEmailExist =
          await User().query().where('email', '=', email).first();
      if (isEmailExist != null) {
        return Response.json({
          'success': false,
          'message': 'Email sudah tersedia',
        });
      }

      final passwordHashed = Hash().make(password);
      var user = await User().query().create({
        'name': name,
        'email': email,
        'password': passwordHashed,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });

      return Response.json({
        'success': true,
        'message': 'Berhasil melakukan register',
        'data': user
      });
    } catch (e) {
      return Response.json({
        'success': false,
        'message': 'Register gagal',
        'error': e.toString()
      });
    }
  }

  Future<Response> logout(Request request) async {
    try {
      final token = request.header('Authorization');
      if (token == null) {
        return Response.json({
          'success': false,
          'message': 'Token sudah tersedia',
        });
      }

      final isValidToken = await Auth().check(token);
      if (!isValidToken) {
        return Response.json({
          'success': false,
          'message': 'Token tidak tersedia',
        });
      }

      await Auth().deleteTokens();

      return Response.json({
        'success': true,
        'message': 'Berhasil logout',
      });
    } catch (e) {
      return Response.json(
          {'success': false, 'message': 'Gagal logout', 'error': e.toString()});
    }
  }
}

final AuthController authController = AuthController();
