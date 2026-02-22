import 'package:estatehub_app/src/data/local/local_storage.dart';
import 'package:estatehub_app/src/ui/features/auth/register/data/register_repository.dart';
import 'package:estatehub_app/src/ui/features/auth/register/data/register_service.dart';
import 'package:estatehub_app/src/utils/app_exception.dart';
import 'package:estatehub_app/src/utils/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRegisterService extends Mock implements RegisterService {}

class MockLocalStorage extends Mock implements LocalStorage {}

void main() {
  late MockRegisterService mockRegisterService;
  late MockLocalStorage mockLocalStorage;
  late RegisterRepository repository;

  const tName = 'Novo Usuário';
  const tEmail = 'novo@teste.com';
  const tPassword = 'senha123';
  const tToken = 'access_token_fake';
  const tUserJson = '{"id":"2","email":"novo@teste.com","name":"Novo Usuário"}';

  final tSuccessResponse = {
    'access_token': tToken,
    'user': {'id': '2', 'email': tEmail, 'name': tName},
  };

  setUp(() {
    mockRegisterService = MockRegisterService();
    mockLocalStorage = MockLocalStorage();
    repository = RegisterRepository(
      registerService: mockRegisterService,
      localStorage: mockLocalStorage,
    );
  });

  group('RegisterRepository', () {
    group('register', () {
      test(
        'deve retornar sucesso e salvar token e usuário quando serviço retornar dados válidos',
        () async {
          when(
            () => mockRegisterService.register(
              name: any(named: 'name'),
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenAnswer((_) async => Result.success(tSuccessResponse));

          when(
            () => mockLocalStorage.saveAccessToken(any()),
          ).thenAnswer((_) async {});

          when(() => mockLocalStorage.saveUser(any())).thenAnswer((_) async {});

          final result = await repository.register(
            name: tName,
            email: tEmail,
            password: tPassword,
          );

          expect(result, isA<Success<void>>());
          verify(
            () => mockRegisterService.register(
              name: tName,
              email: tEmail,
              password: tPassword,
            ),
          ).called(1);
          verify(() => mockLocalStorage.saveAccessToken(tToken)).called(1);
          verify(() => mockLocalStorage.saveUser(tUserJson)).called(1);
        },
      );

      test(
        'deve retornar erro e não salvar nada quando serviço retornar falha genérica',
        () async {
          // Arrange
          const tException = AppException(errorCode: 'ErrUnknown');

          when(
            () => mockRegisterService.register(
              name: any(named: 'name'),
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenAnswer((_) async => Result.error(tException));

          final result = await repository.register(
            name: tName,
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
        'deve retornar erro ErrEmailAlreadyUsed e não salvar nada quando email já estiver em uso',
        () async {
          const tException = AppException(
            errorCode: 'ErrEmailAlreadyUsed',
            statusCode: 409,
          );

          when(
            () => mockRegisterService.register(
              name: any(named: 'name'),
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenAnswer((_) async => Result.error(tException));

          final result = await repository.register(
            name: tName,
            email: tEmail,
            password: tPassword,
          );

          expect(result, isA<Error<void>>());
          final error = (result as Error<void>).error;
          expect(error.errorCode, 'ErrEmailAlreadyUsed');
          expect(error.statusCode, 409);
          verifyNever(() => mockLocalStorage.saveAccessToken(any()));
          verifyNever(() => mockLocalStorage.saveUser(any()));
        },
      );
    });
  });
}
