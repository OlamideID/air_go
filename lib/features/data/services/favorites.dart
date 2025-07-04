import 'dart:convert';

import 'package:flight_test/features/domain/entities/flight.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const _favoritesKey = 'favorite_flights';
  final SharedPreferences _prefs;

  FavoritesService(this._prefs);

  Future<List<Flight>> getFavoriteFlights() async {
    final favoritesJson = _prefs.getStringList(_favoritesKey) ?? [];

    // Decode safely, skip invalid entries
    final flights = favoritesJson
        .map((json) {
          try {
            final decoded = jsonDecode(json);
            if (decoded is Map<String, dynamic>) {
              return Flight.fromJson(decoded);
            }
          } catch (e) {
            // You could optionally log the error or track corrupted entries
          }
          return null;
        })
        .whereType<Flight>()
        .toList();

    return flights;
  }

  Future<bool> toggleFavorite(Flight flight) async {
    final favorites = await getFavoriteFlights();
    final existingIndex = favorites.indexWhere((f) => f.id == flight.id);

    if (existingIndex != -1) {
      // Remove from favorites
      favorites.removeAt(existingIndex);
    } else {
      // Add to favorites
      favorites.add(flight);
    }

    final favoritesJson = favorites.map((f) => jsonEncode(f.toJson())).toList();
    return await _prefs.setStringList(_favoritesKey, favoritesJson);
  }

  Future<bool> isFavorite(String flightId) async {
    final favorites = await getFavoriteFlights();
    return favorites.any((f) => f.id == flightId);
  }

  Future<bool> removeFavorite(String flightId) async {
    final favorites = await getFavoriteFlights();
    favorites.removeWhere((f) => f.id == flightId);
    final favoritesJson = favorites.map((f) => jsonEncode(f.toJson())).toList();
    return await _prefs.setStringList(_favoritesKey, favoritesJson);
  }
}
