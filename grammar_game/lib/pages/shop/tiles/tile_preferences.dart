import 'package:flutter/material.dart';

class TileSkin {
  final int id;
  final String name;
  final Color backgroundColor;
  final Color textColor;
  final int price;
  final bool isDefault;

  TileSkin({
    required this.id,
    required this.name,
    required this.backgroundColor,
    required this.textColor,
    required this.price,
    required this.isDefault,
  });

  factory TileSkin.fromJson(Map<String, dynamic> json) {
    return TileSkin(
      id: json['id'],
      name: json['name'],
      backgroundColor:
          Color(int.parse(json['background_color'].replaceFirst('#', '0xFF'))),
      textColor: Color(int.parse(json['text_color'].replaceFirst('#', '0xFF'))),
      price: json['price'],
      isDefault: json['is_default'] ?? false,
    );
  }
}

class UserPreferences {
  final String userId;
  final int? selectedSkinId;
  final int coins;

  UserPreferences({
    required this.userId,
    this.selectedSkinId,
    required this.coins,
  });

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      userId: json['user_id'],
      selectedSkinId: json['selected_skin_id'],
      coins: json['coins'] ?? 0,
    );
  }
}
