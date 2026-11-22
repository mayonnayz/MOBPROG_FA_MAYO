import 'package:flutter/material.dart';
import 'styled_text.dart';
import '../constants/app_constants.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.title,
    required this.items,
  });

  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: AppConstants.cardColor,
        child: Padding(
          padding: const EdgeInsets.all(
            AppConstants.cardPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StyledText(title.toUpperCase(), 9),
              const SizedBox(height: 15),
              if (items.isEmpty)
                const StyledText('No information available', 8)
              else
                ...items.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: StyledText('• $item', 8),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}