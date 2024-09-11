// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAllSongsHash() => r'0577b73e3f02b57ee058e3f47b70e6cbbe6a0c79';

/// See also [getAllSongs].
@ProviderFor(getAllSongs)
final getAllSongsProvider = AutoDisposeFutureProvider<List<SongModel>>.internal(
  getAllSongs,
  name: r'getAllSongsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getAllSongsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetAllSongsRef = AutoDisposeFutureProviderRef<List<SongModel>>;
String _$getAllFavoriteSongsHash() =>
    r'ab892e58b764061fff1473d8b30ed79137f6896d';

/// See also [getAllFavoriteSongs].
@ProviderFor(getAllFavoriteSongs)
final getAllFavoriteSongsProvider =
    AutoDisposeFutureProvider<List<SongModel>>.internal(
  getAllFavoriteSongs,
  name: r'getAllFavoriteSongsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getAllFavoriteSongsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetAllFavoriteSongsRef = AutoDisposeFutureProviderRef<List<SongModel>>;
String _$homeViewModelHash() => r'e957fc9276810ed95eed34c4cf06fc9aab82b5b5';

/// See also [HomeViewModel].
@ProviderFor(HomeViewModel)
final homeViewModelProvider =
    AutoDisposeNotifierProvider<HomeViewModel, AsyncValue?>.internal(
  HomeViewModel.new,
  name: r'homeViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HomeViewModel = AutoDisposeNotifier<AsyncValue?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
