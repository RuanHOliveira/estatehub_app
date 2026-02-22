import 'package:estatehub_app/src/data/local/local_storage.dart';
import 'package:estatehub_app/src/ui/features/exchange_rates/data/exchange_rate_repository.dart';
import 'package:estatehub_app/src/ui/features/exchange_rates/data/exchange_rate_service.dart';
import 'package:estatehub_app/src/utils/app_exception.dart';
import 'package:estatehub_app/src/utils/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockExchangeRateService extends Mock implements ExchangeRateService {}

class MockLocalStorage extends Mock implements LocalStorage {}

void main() {
  late MockExchangeRateService mockService;
  late MockLocalStorage mockLocalStorage;
  late ExchangeRateRepository repository;

  const tToken = 'access_token_fake';

  final tActiveRate = {
    'id': 'rate-uuid-1',
    'user_id': 'user-uuid-1',
    'target_currency': 'USD',
    'rate': 0.181818,
    'created_at': '2026-02-21T10:00:00Z',
    'updated_at': '2026-02-21T10:00:00Z',
    'deleted_at': null,
  };

  final tInactiveRate = {
    'id': 'rate-uuid-2',
    'user_id': 'user-uuid-1',
    'target_currency': 'USD',
    'rate': 0.190000,
    'created_at': '2026-02-20T08:00:00Z',
    'updated_at': '2026-02-21T10:00:00Z',
    'deleted_at': '2026-02-21T10:00:00Z',
  };

  setUp(() {
    mockService = MockExchangeRateService();
    mockLocalStorage = MockLocalStorage();
    repository = ExchangeRateRepository(
      exchangeRateService: mockService,
      localStorage: mockLocalStorage,
    );
  });

  group('ExchangeRateRepository', () {
    group('getCurrentExchangeRateBrlToUsd', () {
      test(
        'deve retornar sucesso com a taxa ativa quando service retorna lista com deleted_at nulo',
        () async {
          when(
            () => mockLocalStorage.getAccessToken(),
          ).thenAnswer((_) async => tToken);
          when(
            () => mockService.listExchangeRates(token: tToken),
          ).thenAnswer(
            (_) async => Result.success([tInactiveRate, tActiveRate]),
          );

          final result = await repository.getCurrentExchangeRateBrlToUsd();

          expect(result, isA<Success<double?>>());
          final rate = (result as Success<double?>).value;
          expect(rate, 0.181818);
          verify(() => mockLocalStorage.getAccessToken()).called(1);
          verify(() => mockService.listExchangeRates(token: tToken)).called(1);
        },
      );

      test(
        'deve retornar sucesso com null quando service retorna lista vazia',
        () async {
          when(
            () => mockLocalStorage.getAccessToken(),
          ).thenAnswer((_) async => tToken);
          when(
            () => mockService.listExchangeRates(token: tToken),
          ).thenAnswer((_) async => Result.success([]));

          final result = await repository.getCurrentExchangeRateBrlToUsd();

          expect(result, isA<Success<double?>>());
          expect((result as Success<double?>).value, isNull);
        },
      );

      test(
        'deve retornar sucesso com null quando todas as cotações estão inativas (deleted_at != null)',
        () async {
          when(
            () => mockLocalStorage.getAccessToken(),
          ).thenAnswer((_) async => tToken);
          when(
            () => mockService.listExchangeRates(token: tToken),
          ).thenAnswer((_) async => Result.success([tInactiveRate]));

          final result = await repository.getCurrentExchangeRateBrlToUsd();

          expect(result, isA<Success<double?>>());
          expect((result as Success<double?>).value, isNull);
        },
      );

      test(
        'deve retornar erro ErrUnknown quando service falha com erro genérico',
        () async {
          const tException = AppException(errorCode: 'ErrUnknown');

          when(
            () => mockLocalStorage.getAccessToken(),
          ).thenAnswer((_) async => tToken);
          when(
            () => mockService.listExchangeRates(token: tToken),
          ).thenAnswer((_) async => Result.error(tException));

          final result = await repository.getCurrentExchangeRateBrlToUsd();

          expect(result, isA<Error<double?>>());
          expect(
            (result as Error<double?>).error.errorCode,
            'ErrUnknown',
          );
        },
      );

      test(
        'deve chamar service com token vazio quando token é nulo',
        () async {
          const tException = AppException(
            errorCode: 'ErrMissingToken',
            statusCode: 401,
          );

          when(
            () => mockLocalStorage.getAccessToken(),
          ).thenAnswer((_) async => null);
          when(
            () => mockService.listExchangeRates(token: ''),
          ).thenAnswer((_) async => Result.error(tException));

          final result = await repository.getCurrentExchangeRateBrlToUsd();

          expect(result, isA<Error<double?>>());
          expect(
            (result as Error<double?>).error.errorCode,
            'ErrMissingToken',
          );
          verify(() => mockService.listExchangeRates(token: '')).called(1);
        },
      );
    });

    group('saveExchangeRateBrlToUsd', () {
      const tRate = 0.181818;

      test(
        'deve retornar sucesso quando service salva com sucesso',
        () async {
          when(
            () => mockLocalStorage.getAccessToken(),
          ).thenAnswer((_) async => tToken);
          when(
            () => mockService.createExchangeRate(rate: tRate, token: tToken),
          ).thenAnswer((_) async => Result.success({'id': 'rate-uuid-1'}));

          final result = await repository.saveExchangeRateBrlToUsd(tRate);

          expect(result, isA<Success<void>>());
          verify(() => mockLocalStorage.getAccessToken()).called(1);
          verify(
            () => mockService.createExchangeRate(rate: tRate, token: tToken),
          ).called(1);
        },
      );

      test(
        'deve retornar erro ErrInvalidRate quando service rejeita taxa inválida (400)',
        () async {
          const tException = AppException(
            errorCode: 'ErrInvalidRate',
            statusCode: 400,
          );

          when(
            () => mockLocalStorage.getAccessToken(),
          ).thenAnswer((_) async => tToken);
          when(
            () => mockService.createExchangeRate(rate: tRate, token: tToken),
          ).thenAnswer((_) async => Result.error(tException));

          final result = await repository.saveExchangeRateBrlToUsd(tRate);

          expect(result, isA<Error<void>>());
          final error = (result as Error<void>).error;
          expect(error.errorCode, 'ErrInvalidRate');
          expect(error.statusCode, 400);
        },
      );

      test(
        'deve retornar erro ErrUnknown quando service falha com erro genérico',
        () async {
          const tException = AppException(errorCode: 'ErrUnknown');

          when(
            () => mockLocalStorage.getAccessToken(),
          ).thenAnswer((_) async => tToken);
          when(
            () => mockService.createExchangeRate(rate: tRate, token: tToken),
          ).thenAnswer((_) async => Result.error(tException));

          final result = await repository.saveExchangeRateBrlToUsd(tRate);

          expect(result, isA<Error<void>>());
          expect((result as Error<void>).error.errorCode, 'ErrUnknown');
        },
      );

      test(
        'deve chamar service com token vazio quando token é nulo',
        () async {
          const tException = AppException(
            errorCode: 'ErrMissingToken',
            statusCode: 401,
          );

          when(
            () => mockLocalStorage.getAccessToken(),
          ).thenAnswer((_) async => null);
          when(
            () => mockService.createExchangeRate(rate: tRate, token: ''),
          ).thenAnswer((_) async => Result.error(tException));

          final result = await repository.saveExchangeRateBrlToUsd(tRate);

          expect(result, isA<Error<void>>());
          expect(
            (result as Error<void>).error.errorCode,
            'ErrMissingToken',
          );
          verify(
            () => mockService.createExchangeRate(rate: tRate, token: ''),
          ).called(1);
        },
      );
    });
  });
}
