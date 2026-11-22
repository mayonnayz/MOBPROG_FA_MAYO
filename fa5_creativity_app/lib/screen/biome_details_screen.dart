import 'package:fa5_creativity_app/commons/info_card.dart';
import 'package:fa5_creativity_app/constants/app_constants.dart';
import 'package:fa5_creativity_app/models/biome.dart';
import 'package:flutter/material.dart';

import '../commons/styled_text.dart';
import 'biome_list_screen.dart';

class BiomeDetailsScreen extends StatelessWidget {
  const BiomeDetailsScreen({
    super.key,
    required this.biome,
  });

  final Biome biome;

  Widget detailText(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StyledText(title.toUpperCase(), 11),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: StyledText(
              value.isEmpty ? 'Not available' : value,
              9,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = [
      biomeColor(
        biome.colors['grass']!,
        const Color(0xFF4CAF50),
      ),
      biomeColor(
        biome.colors['foliage']!,
        const Color(0xFF558B2F),
      ),
    ];

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.bottomCenter,
            focal: Alignment.bottomCenter,
            colors: colors,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                StyledText(
                  biome.name.toUpperCase(),
                  AppConstants.largeFont,
                  align: TextAlign.center,
                ),

                const SizedBox(height: 30),

                Card(
                  color: Colors.black.withOpacity(0.55),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        detailText('Notes', biome.notes),
                        detailText('Dimension', biome.dimension),
                        detailText('Category', biome.category),
                        detailText('Precipitation', biome.precipitation),
                        detailText('Rarity', biome.rarity),
                        detailText(
                          'Temperature',
                          biome.temperature.toString(),
                        ),
                        detailText(
                          'Version Added',
                          biome.versionAdded,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoCard(
                      title: 'Terrain Features',
                      items: biome.terrainFeatures,
                    ),
                    InfoCard(
                      title: 'Unique Blocks',
                      items: biome.uniqueBlocks,
                    ),
                  ],
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoCard(
                      title: 'Spawning Mobs',
                      items: biome.spawningMobs,
                    ),
                    InfoCard(
                      title: 'Structures Found',
                      items: biome.structuresFound,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
