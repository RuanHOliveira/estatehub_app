import 'package:estatehub_app/src/data/local/local_storage.dart';
import 'package:estatehub_app/src/ui/features/auth/login/data/login_repository.dart';
import 'package:estatehub_app/src/ui/features/auth/login/data/login_service.dart';
import 'package:estatehub_app/src/utils/app_exception.dart';
import 'package:estatehub_app/src/utils/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginService extends Mock implements LoginService {}

class MockLocalStorage extends Mock implements LocalStorage {}

void main() {
  late MockLoginService mockLoginService;
  late MockLocalStorage mockLocalStorage;
  late LoginRepository repository;

  const tEmail = 'usuario@teste.com';
  const tPassword = 'senha123';
  const tToken = 'access_token_fake';
  const tUserJson =
      '{"id":"1","email":"usuario@teste.com","name":"Usuário Teste"}';

  final tSuccessResponse = {
    'access_token': tToken,
    'user': {'id': '1', 'email': tEmail, 'name': 'Usuário Teste'},
  };

  setUp(() {
    mockLoginService = MockLoginService();
    mockLocalStorage = MockLocalStorage();
    repository = LoginRepository(
      loginService: mockLoginService,
      localStorage: mockLocalStorage,
    );
  });

  group('LoginRepository', () {
    group('login', () {
      test(
        'deve retornar sucesso e salvar token e usuário quando serviço retornar dados válidos',
        () async {
          when(
            () => mockLoginService.login(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenAnswer((_) async => Result.success(tSuccessResponse));

          when(
            () => mockLocalStorage.saveAccessToken(any()),
          ).thenAnswer((_) async {});

          when(() => mockLocalStorage.saveUser(any())).thenAnswer((_) async {});

          final result = await repository.login(
            email: tEmail,
            password: tPassword,
          );

          expect(result, isA<Success<void>>());
          verify(
            () => mockLoginService.login(email: tEmail, password: tPassword),
          ).called(1);
          verify(() => mockLocalStorage.saveAccessToken(tToken)).called(1);
          verify(() => mockLocalStorage.saveUser(tUserJson)).called(1);
        },
      );

      test(
        'deve retornar erro e não salvar nada quando serviço retornar falha genérica',
        () async {
          const tException = AppException(errorCode: 'ErrUnknown');

          when(
            () => mockLoginService.login(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenAnswer((_) async => Result.error(tException));

          final result = await repository.login(
            email: tEmail,
            password: tPassword,
          );

          expect(result, isA<Error<void>>());
          expect((result as Error<void>).error.errorCode, 'ErrUnknown');
          verifyNever(() => mockLocalStorage.saveAccessToken(any()));
          verifyNever(() => mockLocalStorage.saveUser(any()));
        },
      );

      test(
        'deve retornar erro ErrUserNotFound e não salvar nada quando usuário não for encontrado',
        () async {
          const tException = AppException(
            errorCode: 'ErrUserNotFound',
            statusCode: 404,
          );

          when(
            () => mockLoginService.login(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenAnswer((_) async => Result.error(tException));

          final result = await repository.login(
            email: tEmail,
            password: tPassword,
          );

          expect(result, isA<Error<void>>());
          final error = (result as Error<void>).error;
          expect(error.errorCode, 'ErrUserNotFound');
          expect(error.statusCode, 404);
          verifyNever(() => mockLocalStorage.saveAccessToken(any()));
          verifyNever(() => mockLocalStorage.saveUser(any()));
        },
      );

      test(
        'deve retornar erro ErrInvalidCredentials e não salvar nada quando email ou senha forem inválidos',
        () async {
          const tException = AppException(
            errorCode: 'ErrInvalidCredentials',
            statusCode: 401,
          );

          when(
            () => mockLoginService.login(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenAnswer((_) async => Result.error(tException));

          final result = await repository.login(
            email: tEmail,
            password: 'senha_errada',
          );

          expect(result, isA<Error<void>>());
          final error = (result as Error<void>).error;
          expect(error.errorCode, 'ErrInvalidCredentials');
          expect(error.statusCode, 401);
          verifyNever(() => mockLocalStorage.saveAccessToken(any()));
          verifyNever(() => mockLocalStorage.saveUser(any()));
        },
      );
    });
  });
}
