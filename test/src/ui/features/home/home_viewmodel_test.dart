import 'package:estatehub_app/src/data/local/local_storage.dart';
import 'package:estatehub_app/src/data/models/property_ad_model.dart';
import 'package:estatehub_app/src/ui/features/home/home_viewmodel.dart';
import 'package:estatehub_app/src/ui/features/property_ads/data/property_ads_repository.dart';
import 'package:estatehub_app/src/utils/app_exception.dart';
import 'package:estatehub_app/src/utils/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPropertyAdsRepository extends Mock implements PropertyAdsRepository {}

class MockLocalStorage extends Mock implements LocalStorage {}

PropertyAdModel _makeAd({
  String id = 'ad-1',
  String userId = 'user-1',
  String type = 'SALE',
  String city = 'São Paulo',
  String neighborhood = 'Centro',
  String street = 'Rua A',
  String state = 'SP',
}) {
  return PropertyAdModel(
    id: id,
    userId: userId,
    type: type,
    priceBrl: 100000.0,
    zipCode: '01000000',
    street: street,
    number: '1',
    neighborhood: neighborhood,
    city: city,
    state: state,
    createdAt: DateTime(2026, 1, 1),
    updatedAt: DateTime(2026, 1, 1),
  );
}

void main() {
  late MockPropertyAdsRepository mockRepository;
  late MockLocalStorage mockLocalStorage;
  late HomeViewModel viewModel;

  const tCurrentUserId = 'user-current';
  const tUserJson =
      '{"id":"$tCurrentUserId","email":"test@test.com","name":"Test User"}';

  setUp(() {
    mockRepository = MockPropertyAdsRepository();
    mockLocalStorage = MockLocalStorage();
    viewModel = HomeViewModel(
      propertyAdsRepository: mockRepository,
      localStorage: mockLocalStorage,
    );
  });

  tearDown(() {
    viewModel.dispose();
  });

  group('HomeViewModel', () {
    group('estado inicial', () {
      test('filteredAds está vazio antes de carregar', () {
        expect(viewModel.filteredAds, isEmpty);
      });

      test('filtro ativo inicial é PropertyAdFilter.all', () {
        expect(viewModel.activeFilter, PropertyAdFilter.all);
      });

      test('searchText inicial está vazio', () {
        expect(viewModel.searchText, '');
      });
    });

    group('loadAds', () {
      test(
        'popula filteredAds quando repository retorna sucesso',
        () async {
          final tAds = [
            _makeAd(id: 'ad-1', type: 'SALE'),
            _makeAd(id: 'ad-2', type: 'RENT'),
          ];

          when(
            () => mockLocalStorage.getUser(),
          ).thenAnswer((_) async => tUserJson);
          when(
            () => mockRepository.fetchPropertyAds(),
          ).thenAnswer((_) async => Result.success(tAds));

          await viewModel.loadAds.execute();

          expect(viewModel.filteredAds.length, 2);
          expect(viewModel.loadAds.success, true);
        },
      );

      test(
        'mantém lista vazia e define estado de erro quando repository falha',
        () async {
          const tException = AppException(errorCode: 'ErrUnknown');

          when(
            () => mockLocalStorage.getUser(),
          ).thenAnswer((_) async => tUserJson);
          when(
            () => mockRepository.fetchPropertyAds(),
          ).thenAnswer((_) async => Result.error(tException));

          await viewModel.loadAds.execute();

          expect(viewModel.filteredAds, isEmpty);
          expect(viewModel.loadAds.error, true);
          expect(
            (viewModel.loadAds.result as Error).error.errorCode,
            'ErrUnknown',
          );
        },
      );
    });

    group('setFilter', () {
      setUp(() async {
        final tAds = [
          _makeAd(id: 'ad-1', userId: tCurrentUserId, type: 'SALE'),
          _makeAd(id: 'ad-2', userId: 'other-user', type: 'RENT'),
          _makeAd(id: 'ad-3', userId: tCurrentUserId, type: 'RENT'),
          _makeAd(id: 'ad-4', userId: 'other-user', type: 'SALE'),
        ];

        when(
          () => mockLocalStorage.getUser(),
        ).thenAnswer((_) async => tUserJson);
        when(
          () => mockRepository.fetchPropertyAds(),
        ).thenAnswer((_) async => Result.success(tAds));

        await viewModel.loadAds.execute();
      });

      test('filtro "all" exibe todos os anúncios', () {
        viewModel.setFilter(PropertyAdFilter.all);
        expect(viewModel.filteredAds.length, 4);
      });

      test('filtro "myAds" exibe apenas anúncios do userId atual', () {
        viewModel.setFilter(PropertyAdFilter.myAds);
        final ids = viewModel.filteredAds.map((a) => a.id).toList();
        expect(ids, containsAll(['ad-1', 'ad-3']));
        expect(ids, isNot(contains('ad-2')));
        expect(ids, isNot(contains('ad-4')));
      });

      test('filtro "rent" exibe apenas anúncios do tipo RENT', () {
        viewModel.setFilter(PropertyAdFilter.rent);
        expect(viewModel.filteredAds.every((a) => a.type == 'RENT'), true);
        expect(viewModel.filteredAds.length, 2);
      });

      test('filtro "sale" exibe apenas anúncios do tipo SALE', () {
        viewModel.setFilter(PropertyAdFilter.sale);
        expect(viewModel.filteredAds.every((a) => a.type == 'SALE'), true);
        expect(viewModel.filteredAds.length, 2);
      });
    });

    group('setSearchText', () {
      setUp(() async {
        final tAds = [
          _makeAd(
            id: 'ad-sp',
            city: 'São Paulo',
            neighborhood: 'Bela Vista',
            street: 'Av. Paulista',
          ),
          _makeAd(
            id: 'ad-rj',
            city: 'Rio de Janeiro',
            neighborhood: 'Copacabana',
            street: 'Rua Barata Ribeiro',
          ),
          _makeAd(
            id: 'ad-bh',
            city: 'Belo Horizonte',
            neighborhood: 'Savassi',
            street: 'Rua Pernambuco',
          ),
        ];

        when(
          () => mockLocalStorage.getUser(),
        ).thenAnswer((_) async => tUserJson);
        when(
          () => mockRepository.fetchPropertyAds(),
        ).thenAnswer((_) async => Result.success(tAds));

        await viewModel.loadAds.execute();
      });

      test('filtra por cidade (case-insensitive)', () {
        viewModel.setSearchText('são paulo');
        expect(viewModel.filteredAds.length, 1);
        expect(viewModel.filteredAds.first.id, 'ad-sp');
      });

      test('filtra por bairro', () {
        viewModel.setSearchText('copacabana');
        expect(viewModel.filteredAds.length, 1);
        expect(viewModel.filteredAds.first.id, 'ad-rj');
      });

      test('filtra por rua', () {
        viewModel.setSearchText('paulista');
        expect(viewModel.filteredAds.length, 1);
        expect(viewModel.filteredAds.first.id, 'ad-sp');
      });

      test('texto vazio retorna todos os anúncios do filtro ativo', () {
        viewModel.setSearchText('são paulo');
        expect(viewModel.filteredAds.length, 1);

        viewModel.setSearchText('');
        expect(viewModel.filteredAds.length, 3);
      });

      test('combinação de filtro + pesquisa funciona corretamente', () async {
        final tAds = [
          _makeAd(
            id: 'sale-sp',
            type: 'SALE',
            city: 'São Paulo',
            neighborhood: 'Centro',
            street: 'Rua X',
          ),
          _makeAd(
            id: 'rent-sp',
            type: 'RENT',
            city: 'São Paulo',
            neighborhood: 'Moema',
            street: 'Rua Y',
          ),
          _makeAd(
            id: 'sale-rj',
            type: 'SALE',
            city: 'Rio de Janeiro',
            neighborhood: 'Centro',
            street: 'Rua Z',
          ),
        ];

        when(
          () => mockLocalStorage.getUser(),
        ).thenAnswer((_) async => tUserJson);
        when(
          () => mockRepository.fetchPropertyAds(),
        ).thenAnswer((_) async => Result.success(tAds));

        await viewModel.loadAds.execute();

        viewModel.setFilter(PropertyAdFilter.sale);
        viewModel.setSearchText('são paulo');

        expect(viewModel.filteredAds.length, 1);
        expect(viewModel.filteredAds.first.id, 'sale-sp');
      });
    });
  });
}
