import 'package:fa4_reverse_engineering/model/item_supply.dart';
import 'package:fa4_reverse_engineering/supply_manager/supply_item.dart';
import 'package:flutter/material.dart';

class SupplyList extends StatelessWidget {
  const SupplyList({
    super.key,
    required this.supplies,
    required this.removeSupply,
  });

  final List<ItemSupply> supplies;
  final void Function(ItemSupply supply) removeSupply;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: supplies.length,
      itemBuilder: (ctx, index) {
        final supply = supplies[index];
        return Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
            margin: Theme.of(context).cardTheme.margin,
          ),
          key: ObjectKey(supply),
          onDismissed: (direction) {
            removeSupply(supply);
          },
          child: SupplyItem(supply),

        );
      },
    );
  }
}