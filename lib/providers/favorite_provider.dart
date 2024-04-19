import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:bit_wall/services/shared_preferences.dart';

class FavoriteNotifier extends ChangeNotifier {
  List<String> _favoriteItems = [];

  List<String> get favoriteItems => _favoriteItems;

  Future<void> loadFavorites() async {
    String? listData =
        await SharedPreferencesService().getString("favoriteList");
    if (listData != null) {
      _favoriteItems = json.decode(listData).cast<String>();
    }
    notifyListeners();
  }

  Future<void> toggleFavorite(String wallpaperId) async {
    if (_favoriteItems.contains(wallpaperId)) {
      _favoriteItems.remove(wallpaperId);
    } else {
      _favoriteItems.add(wallpaperId);
    }
    await SharedPreferencesService().storeString(
      'favoriteList',
      jsonEncode(_favoriteItems),
    );
    notifyListeners();
  }
}
