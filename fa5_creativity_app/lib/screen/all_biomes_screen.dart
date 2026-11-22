
import 'package:fa5_creativity_app/commons/styled_text.dart';
import 'package:fa5_creativity_app/constants/app_constants.dart';
import 'package:fa5_creativity_app/home_screen.dart';
import 'package:fa5_creativity_app/models/biome.dart';
import 'package:fa5_creativity_app/service/biome_service.dart';
import 'package:flutter/material.dart';
import 'biome_list_screen.dart';
import 'biome_details_screen.dart';

class AllBiomesScreen extends StatefulWidget {
  const AllBiomesScreen({super.key});

  @override
  State<AllBiomesScreen> createState() => _AllBiomesScreenState();
}

class _AllBiomesScreenState extends State<AllBiomesScreen> {
  final biomeService = BiomeService();

  String? selectedDimension;
  String? selectedCategory;
  String? selectedRarity;

  late Future<List<Biome>> biomesFuture;

  final dimensions = ['overworld', 'nether', 'end'];

  final categories = [
    'temperate',
    'cold',
    'warm',
    'ocean',
    'underground',
    'beach_special',
    'nether',
    'end',
  ];

  final rarities = [
    'common',
    'uncommon',
    'rare',
    'very_rare',
  ];

  String get backgroundImage {
    switch (selectedDimension) {
      case 'nether':
        return 'assets/images/nether_bg.png';
      case 'end':
        return 'assets/images/end_bg.png';
      default:
        return 'assets/images/dirt_bg.jpg';
    }
  }

  void loadBiomes() {
    setState(() {
      biomesFuture = biomeService.getBiomes(
        dimension: selectedDimension,
        category: selectedCategory,
        rarity: selectedRarity,
      );
    });
  }

  String formatText(String text) {
    return text
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) =>
            word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  Widget filterDropdown(
    String label,
    String? value,
    List<String> options,
    Function(String?) onChanged,
  ) {
    return Expanded(
      child: DropdownButtonFormField<String>(
        value: value,
        isExpanded: true,
        dropdownColor: const Color(0xFF493525),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          filled: true,
          fillColor: Colors.black.withOpacity(0.5),
          border: const OutlineInputBorder(),
        ),
        items: [
          const DropdownMenuItem(
            value: null,
            child: Text('All'),
          ),
          ...options.map(
            (option) => DropdownMenuItem(
              value: option,
              child: Text(formatText(option)),
            ),
          ),
        ],
        onChanged: onChanged,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    biomesFuture = biomeService.getBiomes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: StyledText('EXPLORE BIOMES', AppConstants.smallFont)
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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: DropdownButtonFormField<String>(
                        value: selectedDimension,
                        dropdownColor: const Color(0xFF493525),
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Dimension',
                          labelStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.5),
                          border: const OutlineInputBorder(),
                        ),
                        items: dimensions.map((dimension) {
                          return DropdownMenuItem(
                            value: dimension,
                            child: Text(formatText(dimension)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          selectedDimension = value;
                          loadBiomes();
                        },
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        filterDropdown(
                          'Rarity',
                          selectedRarity,
                          rarities,
                          (value) {
                            selectedRarity = value;
                            loadBiomes();
                          },
                        ),

                        const SizedBox(width: 10),

                        filterDropdown(
                          'Category',
                          selectedCategory,
                          categories,
                          (value) {
                            selectedCategory = value;
                            loadBiomes();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

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
                          'Failed to load biomes!',
                          AppConstants.smallFont,
                        ),
                      );
                    }

                    final biomes = snapshot.data ?? [];

                    if (biomes.isEmpty) {
                      return const Center(
                        child: StyledText(
                          'You hit a dead end :/',
                          AppConstants.smallFont,
                          align: TextAlign.center,
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(15),
                      itemCount: biomes.length,
                      itemBuilder: (context, index) {
                        final biome = biomes[index];

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
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
                                  colors: getBiomeColors(biome),
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: StyledText(
                                      biome.name.toUpperCase(),
                                      AppConstants.smallFont,
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
