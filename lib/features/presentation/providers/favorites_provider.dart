// favorites_provider.dart
import 'package:flight_test/features/data/services/favorites.dart';
import 'package:flight_test/features/domain/entities/flight.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences provider not initialized');
});

final favoritesServiceProvider = Provider<FavoritesService>((ref) {
  return FavoritesService(ref.read(sharedPreferencesProvider));
});

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, AsyncValue<List<Flight>>>((ref) {
      return FavoritesNotifier(ref.read(favoritesServiceProvider));
    });

class FavoritesNotifier extends StateNotifier<AsyncValue<List<Flight>>> {
  final FavoritesService _service;

  FavoritesNotifier(this._service) : super(const AsyncValue.loading()) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _service.getFavoriteFlights());
  }

  Future<void> toggleFavorite(Flight flight) async {
    await AsyncValue.guard(() => _service.toggleFavorite(flight));
    await loadFavorites();
  }

  Future<void> removeFavorite(String flightId) async {
    await AsyncValue.guard(() => _service.removeFavorite(flightId));
    await loadFavorites();
  }

  Future<bool> isFavorite(String flightId) => _service.isFavorite(flightId);
}
