
import 'package:fa5_creativity_app/constants/app_constants.dart';
import 'package:fa5_creativity_app/home_screen.dart';
import 'package:fa5_creativity_app/models/biome.dart';
import 'package:fa5_creativity_app/screen/biome_details_screen.dart';
import 'package:flutter/material.dart';
import '../commons/styled_text.dart';
import '../service/biome_service.dart';


Color biomeColor(String value, Color fallback) {
  try {
    String hex = value.replaceAll('#', '').replaceAll('0x', '');

    if (hex.length == 6) {
      hex = 'FF$hex';
    }

    return Color(int.parse(hex, radix: 16));
  } catch (e) {
    return fallback;
  }
}

List<Color> getBiomeColors(Biome biome) {
  return [
    biomeColor(biome.colors['foliage']!, const Color(0xFF558B2F)),
    biomeColor(biome.colors['grass']!, const Color(0xFF4CAF50)),
  ];
}

class BiomeListScreen extends StatefulWidget {
  const BiomeListScreen({
    super.key,
    required this.filters,
  });

  final Map<String, String> filters;

  @override
  State<BiomeListScreen> createState() => _BiomeListScreenState();
}

class _BiomeListScreenState extends State<BiomeListScreen> {
  final biomeService = BiomeService();

  late Future<List<Biome>> biomesFuture;

  @override
  void initState() {
    super.initState();

    biomesFuture = biomeService.getBiomes(
      dimension: widget.filters['dimension'],
      category: widget.filters['category'],
      rarity: widget.filters['rarity'],
    );
  }

  String formatText(String text) {
    return text
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) =>
            word.isEmpty
                ? word
                : word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/dirt_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: StyledText('YOUR BIOME MATCHES', AppConstants.mediumFont)
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      icon: const Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: FutureBuilder<List<Biome>>(
                  future: biomesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return const Center(
                        child: StyledText(
                          'Something went wrong!',
                          AppConstants.smallFont,
                          align: TextAlign.center,
                        ),
                      );
                    }

                    final biomes = snapshot.data ?? [];

                    if (biomes.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(30),
                          child: StyledText(
                            'You hit a dead end :/\n\nNo biomes match your preferences!',
                            AppConstants.smallFont,
                            align: TextAlign.center,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: biomes.length,
                      itemBuilder: (context, index) {
                        final biome = biomes[index];

                        return Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BiomeDetailsScreen(biome: biome),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(22),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: getBiomeColors(biome),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: StyledText(
                                      biome.name.toUpperCase(),
                                      AppConstants.mediumFont,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
