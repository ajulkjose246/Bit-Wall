import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static late SharedPreferences prefs;
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    prefs = await SharedPreferences.getInstance();
  }

  // store Int data
  storeInt(String key, var value) {
    prefs.setInt(key, value);
  }

  //get int data
  getInt(String key) {
    return prefs.getInt(key);
  }

  // store String data
  storeString(String key, String value) {
    prefs.setString(key, value);
  }

  //get String data
  getString(String key) {
    return prefs.getString(key);
  }
}
