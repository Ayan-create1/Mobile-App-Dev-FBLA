import 'package:supabase_flutter/supabase_flutter.dart';
import '../tiles/tile_preferences.dart';

class ShopService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<TileSkin>> getAllSkins() async {
    try {
      // Query the database
      final response = await _supabase
          .from('tile_skins')
          .select('*')
          .order('price', ascending: true);

      // Debug: Check what we received
      print('Database response type: ${response.runtimeType}');
      print('Database response length: ${response.length ?? 0}');

      // Convert each item to TileSkin
      final List<TileSkin> skins = [];
      for (int i = 0; i < response.length; i++) {
        try {
          final skinData = response[i];
          print('Processing skin $i: $skinData');

          final skin = TileSkin.fromJson(skinData);
          skins.add(skin);
        } catch (e) {
          print('Error processing skin at index $i: $e');
          // Continue processing other skins instead of failing completely
          continue;
        }
      }

      print('Successfully loaded ${skins.length} skins');
      return skins;
    } on PostgrestException catch (e) {
      // Handle Supabase-specific errors
      print('Database error: ${e.message}');
      throw Exception('Database error: ${e.message}');
    } catch (e) {
      // Handle general errors
      print('Unexpected error loading skins: $e');
      throw Exception('Failed to load skins: $e');
    }
  }

/*
  Future<List<TileSkin>> getAllSkins() async {
    try {
      final response =
          await _supabase.from('tile_skins').select('*').order('price');

      return (response as List).map((skin) => TileSkin.fromJson(skin)).toList();
    } catch (e) {
      throw Exception('Failed to load skins: $e');
    }
  }
*/
  // Get user's owned skins
  Future<List<int>> getUserOwnedSkins() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      final response = await _supabase
          .from('user_skins')
          .select('skin_id')
          .eq('user_id', userId);

      return (response as List).map((item) => item['skin_id'] as int).toList();
    } catch (e) {
      throw Exception('Failed to load owned skins: $e');
    }
  }

  Future<UserPreferences> getUserPreferences() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      final response = await _supabase
          .from('user_preferences')
          .select('*')
          .eq('user_id', userId)
          .maybeSingle();

      if (response == null) {
        // Create default preferences if none exist
        await _supabase.from('user_preferences').insert({
          'user_id': userId,
          'selected_skin_id': 1, // Default skin
        });

        // Get points from profiles table
        final profileResponse = await _supabase
            .from('profiles')
            .select('points')
            .eq('id', userId)
            .single();

        return UserPreferences(
          userId: userId,
          selectedSkinId: 1,
          coins: profileResponse['points'] ?? 0,
        );
      }

      // Get points from profiles table
      final profileResponse = await _supabase
          .from('profiles')
          .select('points')
          .eq('id', userId)
          .single();

      // Create UserPreferences with points from profiles table
      final prefsData = Map<String, dynamic>.from(response);
      prefsData['coins'] = profileResponse['points'] ?? 0;

      return UserPreferences.fromJson(prefsData);
    } catch (e) {
      throw Exception('Failed to load user preferences: $e');
    }
  }

  // Purchase a skin
  Future<bool> purchaseSkin(int skinId, int price) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      // Get current points from profiles table
      final profileResponse = await _supabase
          .from('profiles')
          .select('points')
          .eq('id', userId)
          .single();

      final currentPoints = profileResponse['points'] ?? 0;

      if (currentPoints < price) {
        throw Exception('Not enough points');
      }

      // Start transaction-like operations
      // 1. Add skin to user_skins
      await _supabase.from('user_skins').insert({
        'user_id': userId,
        'skin_id': skinId,
      });

      // 2. Deduct points from profiles table
      await _supabase
          .from('profiles')
          .update({'points': currentPoints - price}).eq('id', userId);

      return true;
    } catch (e) {
      throw Exception('Failed to purchase skin: $e');
    }
  }

  // Select a skin
  Future<void> selectSkin(int skinId) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      await _supabase
          .from('user_preferences')
          .update({'selected_skin_id': skinId}).eq('user_id', userId);
    } catch (e) {
      throw Exception('Failed to select skin: $e');
    }
  }

  // Get currently selected skin
  Future<TileSkin?> getSelectedSkin() async {
    try {
      final prefs = await getUserPreferences();
      if (prefs.selectedSkinId == null) return null;

      final response = await _supabase
          .from('tile_skins')
          .select('*')
          .eq('id', prefs.selectedSkinId!)
          .single();

      return TileSkin.fromJson(response);
    } catch (e) {
      return null; // Return null if no skin selected or error
    }
  }

//!Don't need
  // Add points (for rewards, achievements, etc.)
  Future<void> addPoints(int amount) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      // Get current points from profiles table
      final profileResponse = await _supabase
          .from('profiles')
          .select('points')
          .eq('id', userId)
          .single();

      final currentPoints = profileResponse['points'] ?? 0;

      await _supabase
          .from('profiles')
          .update({'points': currentPoints + amount}).eq('id', userId);
    } catch (e) {
      throw Exception('Failed to add points: $e');
    }
  }

  // Helper method to get current points directly
  Future<int> getCurrentPoints() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      final response = await _supabase
          .from('profiles')
          .select('points')
          .eq('id', userId)
          .single();

      return response['points'] ?? 0;
    } catch (e) {
      throw Exception('Failed to get current points: $e');
    }
  }
}
