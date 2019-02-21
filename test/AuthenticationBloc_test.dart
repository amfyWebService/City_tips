import 'package:city_tips/core/auth/auth.dart';
import 'package:city_tips/core/repositories/UserRepository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthenticationBloc', () {
    AuthenticationBloc authenticationBloc;

    setUp((){
      authenticationBloc = AuthenticationBloc(userRepository: UserRepository());
    });

    test("Initial state", (){
      expect(authenticationBloc.initialState, AuthenticationUninitialized());
    });
  });
}