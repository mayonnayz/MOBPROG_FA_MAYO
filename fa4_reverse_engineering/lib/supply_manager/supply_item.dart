import 'package:fa4_reverse_engineering/model/item_supply.dart';
import 'package:flutter/material.dart';

class SupplyItem extends StatelessWidget {
  final ItemSupply supply;

  const SupplyItem(this.supply, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                supply.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '\$${supply.price.toStringAsFixed(2)} x ${supply.quantity} = \$${(supply.price * supply.quantity).toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 25,
                    height: 25,
                    color: supply.parameter.color,
                  ),
                  const SizedBox(width: 7),
                  Text(
                    supply.parameter.parameterName,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
