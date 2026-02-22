import 'package:estatehub_app/src/data/local/local_storage.dart';
import 'package:estatehub_app/src/data/models/property_ad_model.dart';
import 'package:estatehub_app/src/data/models/via_cep_model.dart';
import 'package:estatehub_app/src/ui/features/property_ads/data/property_ad_input.dart';
import 'package:estatehub_app/src/ui/features/property_ads/data/property_ads_repository.dart';
import 'package:estatehub_app/src/ui/features/property_ads/data/property_ads_service.dart';
import 'package:estatehub_app/src/utils/app_exception.dart';
import 'package:estatehub_app/src/utils/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPropertyAdsService extends Mock implements PropertyAdsService {}

class MockLocalStorage extends Mock implements LocalStorage {}

void main() {
  late MockPropertyAdsService mockService;
  late MockLocalStorage mockLocalStorage;
  late PropertyAdsRepository repository;

  const tToken = 'access_token_fake';

  final tAdJson = {
    'id': 'ad-uuid-1',
    'user_id': 'user-uuid-1',
    'type': 'SALE',
    'price_brl': 450000.0,
    'price_usd': 81818.18,
    'image_path': null,
    'image_data': null,
    'zip_code': '01310100',
    'street': 'Avenida Paulista',
    'number': '1000',
    'neighborhood': 'Bela Vista',
    'city': 'São Paulo',
    'state': 'SP',
    'complement': null,
    'created_at': '2026-02-21T10:30:00Z',
    'updated_at': '2026-02-21T10:30:00Z',
  };

  final tRentAdJson = {
    'id': 'ad-uuid-2',
    'user_id': 'user-uuid-2',
    'type': 'RENT',
    'price_brl': 3500.0,
    'price_usd': null,
    'image_path': null,
    'image_data': null,
    'zip_code': '04538133',
    'street': 'Rua Funchal',
    'number': '418',
    'neighborhood': 'Vila Olímpia',
    'city': 'São Paulo',
    'state': 'SP',
    'complement': 'Apto 12',
    'created_at': '2026-02-20T08:00:00Z',
    'updated_at': '2026-02-20T08:00:00Z',
  };

  setUp(() {
    mockService = MockPropertyAdsService();
    mockLocalStorage = MockLocalStorage();
    repository = PropertyAdsRepository(
      propertyAdsService: mockService,
      localStorage: mockLocalStorage,
    );
  });

  group('PropertyAdsRepository', () {
    group('fetchPropertyAds', () {
      test(
        'deve retornar sucesso com lista mapeada quando service retorna dados válidos',
        () async {
          when(
            () => mockLocalStorage.getAccessToken(),
          ).thenAnswer((_) async => tToken);
          when(
            () => mockService.listPropertyAds(token: tToken),
          ).thenAnswer((_) async => Result.success([tAdJson, tRentAdJson]));

          final result = await repository.fetchPropertyAds();

          expect(result, isA<Success<List<PropertyAdModel>>>());
          final ads = (result as Success<List<PropertyAdModel>>).value;
          expect(ads.length, 2);
          expect(ads[0].id, 'ad-uuid-1');
          expect(ads[0].type, 'SALE');
          expect(ads[0].priceBrl, 450000.0);
          expect(ads[1].id, 'ad-uuid-2');
          expect(ads[1].type, 'RENT');
          expect(ads[1].complement, 'Apto 12');
          verify(() => mockLocalStorage.getAccessToken()).called(1);
          verify(() => mockService.listPropertyAds(token: tToken)).called(1);
        },
      );

      test(
        'deve retornar sucesso com lista vazia quando service retorna array vazio',
        () async {
          when(
            () => mockLocalStorage.getAccessToken(),
          ).thenAnswer((_) async => tToken);
          when(
            () => mockService.listPropertyAds(token: tToken),
          ).thenAnswer((_) async => Result.success([]));

          final result = await repository.fetchPropertyAds();

          expect(result, isA<Success<List<PropertyAdModel>>>());
          expect((result as Success<List<PropertyAdModel>>).value, isEmpty);
        },
      );

      test(
        'deve retornar erro ErrUnknown quando service retorna falha genérica',
        () async {
          const tException = AppException(errorCode: 'ErrUnknown');

          when(
            () => mockLocalStorage.getAccessToken(),
          ).thenAnswer((_) async => tToken);
          when(
            () => mockService.listPropertyAds(token: tToken),
          ).thenAnswer((_) async => Result.error(tException));

          final result = await repository.fetchPropertyAds();

          expect(result, isA<Error<List<PropertyAdModel>>>());
          expect(
            (result as Error<List<PropertyAdModel>>).error.errorCode,
            'ErrUnknown',
          );
        },
      );

      test(
        'deve retornar erro ErrMissingToken quando service retorna 401 sem token',
        () async {
          const tException = AppException(
            errorCode: 'ErrMissingToken',
            statusCode: 401,
          );

          when(
            () => mockLocalStorage.getAccessToken(),
          ).thenAnswer((_) async => null);
          when(
            () => mockService.listPropertyAds(token: ''),
          ).thenAnswer((_) async => Result.error(tException));

          final result = await repository.fetchPropertyAds();

          expect(result, isA<Error<List<PropertyAdModel>>>());
          final error = (result as Error<List<PropertyAdModel>>).error;
          expect(error.errorCode, 'ErrMissingToken');
          expect(error.statusCode, 401);
        },
      );

      test(
        'deve retornar erro ErrInvalidToken quando service retorna 401 token inválido',
        () async {
          const tException = AppException(
            errorCode: 'ErrInvalidToken',
            statusCode: 401,
          );

          when(
            () => mockLocalStorage.getAccessToken(),
          ).thenAnswer((_) async => tToken);
          when(
            () => mockService.listPropertyAds(token: tToken),
          ).thenAnswer((_) async => Result.error(tException));

          final result = await repository.fetchPropertyAds();

          expect(result, isA<Error<List<PropertyAdModel>>>());
          final error = (result as Error<List<PropertyAdModel>>).error;
          expect(error.errorCode, 'ErrInvalidToken');
          expect(error.statusCode, 401);
        },
      );
    });

    group('deletePropertyAd', () {
      const tAdId = 'ad-uuid-1';

      test(
        'deve retornar sucesso quando service deleta com sucesso',
        () async {
          when(
            () => mockLocalStorage.getAccessToken(),
          ).thenAnswer((_) async => tToken);
          when(
            () => mockService.deletePropertyAd(id: tAdId, token: tToken),
          ).thenAnswer((_) async => Result.success(null));

          final result = await repository.deletePropertyAd(tAdId);

          expect(result, isA<Success<void>>());
          verify(() => mockLocalStorage.getAccessToken()).called(1);
          verify(
            () => mockService.deletePropertyAd(id: tAdId, token: tToken),
          ).called(1);
        },
      );

      test(
        'deve retornar erro ErrPropertyAdNotFound quando anúncio não existe (404)',
        () async {
          const tException = AppException(
            errorCode: 'ErrPropertyAdNotFound',
            statusCode: 404,
          );

          when(
            () => mockLocalStorage.getAccessToken(),
          ).thenAnswer((_) async => tToken);
          when(
            () => mockService.deletePropertyAd(id: tAdId, token: tToken),
          ).thenAnswer((_) async => Result.error(tException));

          final result = await repository.deletePropertyAd(tAdId);

          expect(result, isA<Error<void>>());
          final error = (result as Error<void>).error;
          expect(error.errorCode, 'ErrPropertyAdNotFound');
          expect(error.statusCode, 404);
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
            () => mockService.deletePropertyAd(id: tAdId, token: ''),
          ).thenAnswer((_) async => Result.error(tException));

          final result = await repository.deletePropertyAd(tAdId);

          expect(result, isA<Error<void>>());
          expect((result as Error<void>).error.errorCode, 'ErrMissingToken');
          verify(
            () => mockService.deletePropertyAd(id: tAdId, token: ''),
          ).called(1);
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
            () => mockService.deletePropertyAd(id: tAdId, token: tToken),
          ).thenAnswer((_) async => Result.error(tException));

          final result = await repository.deletePropertyAd(tAdId);

          expect(result, isA<Error<void>>());
          expect((result as Error<void>).error.errorCode, 'ErrUnknown');
        },
      );
    });

    group('createPropertyAd', () {
      const tInput = PropertyAdInput(
        type: 'SALE',
        priceBrl: '450000.00',
        zipCode: '01310100',
        street: 'Avenida Paulista',
        number: '1000',
        neighborhood: 'Bela Vista',
        city: 'São Paulo',
        state: 'SP',
      );

      test(
        'deve retornar Success<PropertyAdModel> quando service retorna dados válidos',
        () async {
          when(
            () => mockLocalStorage.getAccessToken(),
          ).thenAnswer((_) async => tToken);
          when(
            () => mockService.createPropertyAd(input: tInput, token: tToken),
          ).thenAnswer((_) async => Result.success(tAdJson));

          final result = await repository.createPropertyAd(tInput);

          expect(result, isA<Success<PropertyAdModel>>());
          final ad = (result as Success<PropertyAdModel>).value;
          expect(ad.id, 'ad-uuid-1');
          expect(ad.type, 'SALE');
          expect(ad.priceBrl, 450000.0);
          verify(() => mockLocalStorage.getAccessToken()).called(1);
          verify(
            () => mockService.createPropertyAd(input: tInput, token: tToken),
          ).called(1);
        },
      );

      test(
        'deve retornar erro ErrInvalidPrice quando preço é inválido (400)',
        () async {
          const tException = AppException(
            errorCode: 'ErrInvalidPrice',
            statusCode: 400,
          );

          when(
            () => mockLocalStorage.getAccessToken(),
          ).thenAnswer((_) async => tToken);
          when(
            () => mockService.createPropertyAd(input: tInput, token: tToken),
          ).thenAnswer((_) async => Result.error(tException));

          final result = await repository.createPropertyAd(tInput);

          expect(result, isA<Error<PropertyAdModel>>());
          final error = (result as Error<PropertyAdModel>).error;
          expect(error.errorCode, 'ErrInvalidPrice');
          expect(error.statusCode, 400);
        },
      );

      test(
        'deve retornar erro ErrInvalidAdType quando tipo de anúncio é inválido',
        () async {
          const tException = AppException(
            errorCode: 'ErrInvalidAdType',
            statusCode: 400,
          );

          when(
            () => mockLocalStorage.getAccessToken(),
          ).thenAnswer((_) async => tToken);
          when(
            () => mockService.createPropertyAd(input: tInput, token: tToken),
          ).thenAnswer((_) async => Result.error(tException));

          final result = await repository.createPropertyAd(tInput);

          expect(result, isA<Error<PropertyAdModel>>());
          expect(
            (result as Error<PropertyAdModel>).error.errorCode,
            'ErrInvalidAdType',
          );
        },
      );

      test(
        'deve retornar erro ErrMissingAddressField quando campo de endereço está ausente',
        () async {
          const tException = AppException(
            errorCode: 'ErrMissingAddressField',
            statusCode: 400,
          );

          when(
            () => mockLocalStorage.getAccessToken(),
          ).thenAnswer((_) async => tToken);
          when(
            () => mockService.createPropertyAd(input: tInput, token: tToken),
          ).thenAnswer((_) async => Result.error(tException));

          final result = await repository.createPropertyAd(tInput);

          expect(result, isA<Error<PropertyAdModel>>());
          expect(
            (result as Error<PropertyAdModel>).error.errorCode,
            'ErrMissingAddressField',
          );
        },
      );

      test(
        'deve retornar erro ErrImageTooLarge quando imagem excede 5MB',
        () async {
          const tException = AppException(
            errorCode: 'ErrImageTooLarge',
            statusCode: 400,
          );

          when(
            () => mockLocalStorage.getAccessToken(),
          ).thenAnswer((_) async => tToken);
          when(
            () => mockService.createPropertyAd(input: tInput, token: tToken),
          ).thenAnswer((_) async => Result.error(tException));

          final result = await repository.createPropertyAd(tInput);

          expect(result, isA<Error<PropertyAdModel>>());
          expect(
            (result as Error<PropertyAdModel>).error.errorCode,
            'ErrImageTooLarge',
          );
        },
      );

      test(
        'deve retornar erro ErrInvalidImageType quando tipo de imagem é inválido',
        () async {
          const tException = AppException(
            errorCode: 'ErrInvalidImageType',
            statusCode: 400,
          );

          when(
            () => mockLocalStorage.getAccessToken(),
          ).thenAnswer((_) async => tToken);
          when(
            () => mockService.createPropertyAd(input: tInput, token: tToken),
          ).thenAnswer((_) async => Result.error(tException));

          final result = await repository.createPropertyAd(tInput);

          expect(result, isA<Error<PropertyAdModel>>());
          expect(
            (result as Error<PropertyAdModel>).error.errorCode,
            'ErrInvalidImageType',
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
            () => mockService.createPropertyAd(input: tInput, token: ''),
          ).thenAnswer((_) async => Result.error(tException));

          final result = await repository.createPropertyAd(tInput);

          expect(result, isA<Error<PropertyAdModel>>());
          expect(
            (result as Error<PropertyAdModel>).error.errorCode,
            'ErrMissingToken',
          );
          verify(
            () => mockService.createPropertyAd(input: tInput, token: ''),
          ).called(1);
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
            () => mockService.createPropertyAd(input: tInput, token: tToken),
          ).thenAnswer((_) async => Result.error(tException));

          final result = await repository.createPropertyAd(tInput);

          expect(result, isA<Error<PropertyAdModel>>());
          expect(
            (result as Error<PropertyAdModel>).error.errorCode,
            'ErrUnknown',
          );
        },
      );
    });

    group('fetchAddressByCep', () {
      const tCep = '01310100';
      const tViaCep = ViaCepModel(
        zipCode: '01310100',
        street: 'Avenida Paulista',
        neighborhood: 'Bela Vista',
        city: 'São Paulo',
        state: 'SP',
        complement: '',
      );

      test(
        'deve retornar Success<ViaCepModel> com campos preenchidos quando CEP é válido',
        () async {
          when(
            () => mockLocalStorage.getAccessToken(),
          ).thenAnswer((_) async => tToken);
          when(
            () => mockService.fetchAddressByCep(cep: tCep, token: tToken),
          ).thenAnswer((_) async => Result.success(tViaCep));

          final result = await repository.fetchAddressByCep(tCep);

          expect(result, isA<Success<ViaCepModel>>());
          final model = (result as Success<ViaCepModel>).value;
          expect(model.zipCode, '01310100');
          expect(model.street, 'Avenida Paulista');
          expect(model.city, 'São Paulo');
          expect(model.state, 'SP');
          verify(() => mockLocalStorage.getAccessToken()).called(1);
          verify(
            () => mockService.fetchAddressByCep(cep: tCep, token: tToken),
          ).called(1);
        },
      );

      test(
        'deve retornar erro ErrCEPNotFound quando CEP não é encontrado (404)',
        () async {
          const tException = AppException(
            errorCode: 'ErrCEPNotFound',
            statusCode: 404,
          );

          when(
            () => mockLocalStorage.getAccessToken(),
          ).thenAnswer((_) async => tToken);
          when(
            () => mockService.fetchAddressByCep(cep: tCep, token: tToken),
          ).thenAnswer((_) async => Result.error(tException));

          final result = await repository.fetchAddressByCep(tCep);

          expect(result, isA<Error<ViaCepModel>>());
          final error = (result as Error<ViaCepModel>).error;
          expect(error.errorCode, 'ErrCEPNotFound');
          expect(error.statusCode, 404);
        },
      );

      test(
        'deve retornar erro ErrInvalidCEP quando CEP tem formato inválido (400)',
        () async {
          const tException = AppException(
            errorCode: 'ErrInvalidCEP',
            statusCode: 400,
          );

          when(
            () => mockLocalStorage.getAccessToken(),
          ).thenAnswer((_) async => tToken);
          when(
            () => mockService.fetchAddressByCep(cep: tCep, token: tToken),
          ).thenAnswer((_) async => Result.error(tException));

          final result = await repository.fetchAddressByCep(tCep);

          expect(result, isA<Error<ViaCepModel>>());
          expect(
            (result as Error<ViaCepModel>).error.errorCode,
            'ErrInvalidCEP',
          );
        },
      );

      test(
        'deve retornar erro ErrExternalServiceFailure quando ViaCEP está indisponível (502)',
        () async {
          const tException = AppException(
            errorCode: 'ErrExternalServiceFailure',
            statusCode: 502,
          );

          when(
            () => mockLocalStorage.getAccessToken(),
          ).thenAnswer((_) async => tToken);
          when(
            () => mockService.fetchAddressByCep(cep: tCep, token: tToken),
          ).thenAnswer((_) async => Result.error(tException));

          final result = await repository.fetchAddressByCep(tCep);

          expect(result, isA<Error<ViaCepModel>>());
          final error = (result as Error<ViaCepModel>).error;
          expect(error.errorCode, 'ErrExternalServiceFailure');
          expect(error.statusCode, 502);
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
            () => mockService.fetchAddressByCep(cep: tCep, token: ''),
          ).thenAnswer((_) async => Result.error(tException));

          final result = await repository.fetchAddressByCep(tCep);

          expect(result, isA<Error<ViaCepModel>>());
          expect(
            (result as Error<ViaCepModel>).error.errorCode,
            'ErrMissingToken',
          );
          verify(
            () => mockService.fetchAddressByCep(cep: tCep, token: ''),
          ).called(1);
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
            () => mockService.fetchAddressByCep(cep: tCep, token: tToken),
          ).thenAnswer((_) async => Result.error(tException));

          final result = await repository.fetchAddressByCep(tCep);

          expect(result, isA<Error<ViaCepModel>>());
          expect(
            (result as Error<ViaCepModel>).error.errorCode,
            'ErrUnknown',
          );
        },
      );
    });
  });
}
