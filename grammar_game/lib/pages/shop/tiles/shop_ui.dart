// screens/shop_screen.dart
import 'package:flutter/material.dart';
import 'package:grammar_game/pages/home_page/home_page.dart';
import '../tiles/shop_service.dart';
import '../tiles/tile_preferences.dart';
import '../../drag_and_drop/matching.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final ShopService _shopService = ShopService();
  List<TileSkin> _allSkins = [];
  List<int> _ownedSkins = [];
  UserPreferences? _userPrefs;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadShopData();
  }

  Future<void> _loadShopData() async {
    try {
      setState(() => _isLoading = true);

      final futures = await Future.wait([
        _shopService.getAllSkins(),
        _shopService.getUserOwnedSkins(),
        _shopService.getUserPreferences(),
      ]);

      setState(() {
        _allSkins = futures[0] as List<TileSkin>;
        _ownedSkins = futures[1] as List<int>;
        _userPrefs = futures[2] as UserPreferences;
        _isLoading = false;
        _error = null;
      });
      print(futures[0]);
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _purchaseSkin(TileSkin skin) async {
    try {
      await _shopService.purchaseSkin(skin.id, skin.price);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${skin.name} purchased successfully!')),
      );
      _loadShopData(); // Refresh data
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to purchase: ${e.toString()}')),
      );
    }
  }

  Future<void> _selectSkin(TileSkin skin) async {
    try {
      await _shopService.selectSkin(skin.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${skin.name} selected!')),
      );
      _loadShopData(); // Refresh data
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to select skin: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tile Skins Shop'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.home),
          color: Colors.white,
          splashRadius: 50.0,
          splashColor: Colors.black,
          iconSize: screenWidth * 0.1,
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
              (route) => false,
            );
          },
        ),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Icon(Icons.monetization_on, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  '${_userPrefs?.coins ?? 0}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Error: $_error'),
                      ElevatedButton(
                        onPressed: _loadShopData,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: _allSkins.length,
                  itemBuilder: (context, index) {
                    final skin = _allSkins[index];
                    final isOwned =
                        _ownedSkins.contains(skin.id) || skin.isDefault;
                    final isSelected = _userPrefs?.selectedSkinId == skin.id;
                    final canAfford = (_userPrefs?.coins ?? 0) >= skin.price;

                    return Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            // Skin name
                            Text(
                              skin.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 5),

                            // Tile preview
                            AnswerBox(
                              answer: 'Example',
                              tileSkin: skin,
                            ),

                            const SizedBox(height: 8),

                            // Status and actions
                            if (isSelected)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'SELECTED',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            else if (isOwned)
                              ElevatedButton(
                                onPressed: () => _selectSkin(skin),
                                child: const Text('SELECT'),
                              )
                            else
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.monetization_on,
                                          color: Colors.amber, size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${skin.price}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: canAfford
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  ElevatedButton(
                                    onPressed: canAfford
                                        ? () => _purchaseSkin(skin)
                                        : null,
                                    child: const Text('BUY'),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
