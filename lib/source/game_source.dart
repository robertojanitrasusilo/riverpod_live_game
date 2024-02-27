// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// ignore: unused_import
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:live_game_riverpod/models/game.dart';

class GameSource {
  static Future<List<Game>?> getLive() async {
    try {
      String url = 'https://www.freetogame.com/api/games';
      final response = await http.get(
        Uri.parse(url),
      );
      debugPrint('Response: ${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        return data.map((e) => Game.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return null;
    }
  }
}
