import 'package:fa4_reverse_engineering/chart/chart_bar.dart';
import 'package:fa4_reverse_engineering/model/item_supply.dart';
import 'package:fa4_reverse_engineering/model/parameter.dart';
import 'package:flutter/material.dart';

class SupplyChart extends StatelessWidget {
  const SupplyChart({
    super.key,
    required this.supplies,
    required this.parameters,
  });

  final List<ItemSupply> supplies;
  final List<Parameter> parameters;

  int totalQuantity(Parameter parameter) {
    return supplies
        .where(
          (supply) => supply.parameter.parameterName == parameter.parameterName,
        )
        .fold(0, (sum, supply) => sum + supply.quantity);
  }

  int get maxTotalQuantity {
    int maxTotal = 0;

    for (final parameter in parameters) {
      final total = totalQuantity(parameter);

      if (total > maxTotal) {
        maxTotal = total;
      }
    }

    return maxTotal;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor.withOpacity(.3),
            Theme.of(context).primaryColor.withOpacity(0),
          ],  
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final parameter in parameters)
                  ChartBar(
                    fill: maxTotalQuantity == 0
                        ? 0
                        : totalQuantity(parameter) / maxTotalQuantity,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: parameters.map((parameter) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Container(
                    height: 25,
                    decoration: BoxDecoration(
                      color: parameter.color,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
