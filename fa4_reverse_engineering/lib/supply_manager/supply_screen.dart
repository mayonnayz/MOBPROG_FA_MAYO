import 'package:fa4_reverse_engineering/data/items.dart';
import 'package:fa4_reverse_engineering/data/parameters.dart';
import 'package:fa4_reverse_engineering/model/item_supply.dart';
import 'package:fa4_reverse_engineering/model/parameter.dart';
import 'package:fa4_reverse_engineering/supply_manager/add_supply.dart';
import 'package:fa4_reverse_engineering/supply_manager/supply_list.dart';
import 'package:fa4_reverse_engineering/chart/supply_chart.dart';
import 'package:flutter/material.dart';

class SupplyManagerScreen extends StatefulWidget {
  final VoidCallback onBack;
  final List<Parameter> parameters;

  const SupplyManagerScreen({
    super.key,
    required this.onBack,
    required this.parameters,
  });

  @override
  State<SupplyManagerScreen> createState() => _SupplyManagerScreenState();
}

class _SupplyManagerScreenState extends State<SupplyManagerScreen> {
  final List<ItemSupply> supplies = List.from(items);

  void addSupply() async {
    final result = await Navigator.push<ItemSupply>(
      context,
      MaterialPageRoute(
        builder: (context) => AddSupplyScreen(
          parameters: parameters,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        supplies.add(result);
        items.add(result);
      });

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('${result.name} added successfully'),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: widget.onBack,
                  icon: Icon(Icons.arrow_back),
                  color: Theme.of(context).primaryColor,
                ),
                Text(
                  'Supply Manager',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: addSupply,
                  icon: Icon(Icons.add),
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Column(
                  children: [
                    SupplyChart(
                      supplies: supplies,
                      parameters: widget.parameters,
                    ),
                    const SizedBox(height: 14),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                            Expanded(
                              child: SupplyList(
                                supplies: supplies,
                                removeSupply: (supply) {
                                  setState(() {
                                    supplies.remove(supply);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
