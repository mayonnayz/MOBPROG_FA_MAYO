import 'package:fa4_reverse_engineering/model/item_supply.dart';
import 'package:fa4_reverse_engineering/model/parameter.dart';
import 'package:flutter/material.dart';

class AddSupplyScreen extends StatefulWidget {
  final List<Parameter> parameters;

  const AddSupplyScreen({
    super.key,
    required this.parameters,
  });

  @override
  State<AddSupplyScreen> createState() => _AddSupplyScreenState();
}

class _AddSupplyScreenState extends State<AddSupplyScreen> {
  final nameController = TextEditingController();
  final priceController = TextEditingController(text: '1.00');

  int quantity = 1;
  String? selectedParameterId;

  @override
  void initState() {
    super.initState();

    if (widget.parameters.isNotEmpty) {
      selectedParameterId = widget.parameters.first.id;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  InputDecoration inputStyle(String hint) {
    return InputDecoration(
      hintText: hint,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 12,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  void saveSupply() {
    final price = double.tryParse(priceController.text);

    if (nameController.text.trim().isEmpty ||
        price == null ||
        price < 0 ||
        selectedParameterId == null) {
      return;
    }

    final selectedParameter = widget.parameters.firstWhere(
      (item) => item.id == selectedParameterId,
    );

    Navigator.pop(
      context,
      ItemSupply(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: nameController.text.trim(),
        quantity: quantity,
        price: price,
        parameter: selectedParameter,
      ),
    );
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
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  color: Theme.of(context).primaryColor,
                ),
                Text(
                  'Add a new supply',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 80,),
            Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: SizedBox(
                    width: 450,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: 'Item Name',
                            border: OutlineInputBorder(),
                          ),
                          style: TextStyle(color: Theme.of(context).primaryColor,),
                        ),
                        const SizedBox(height: 30),
                        InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Quantity',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 12,
                            ),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (quantity > 1) {
                                    setState(() {
                                      quantity--;
                                    });
                                  }
                                },
                                icon: Icon(
                                  Icons.remove,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '$quantity',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    quantity++;
                                  });
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          controller: priceController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Unit Price',
                            prefixText: '\$ ',
                            border: OutlineInputBorder(),
                          ),
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(height: 30),
                        DropdownButtonFormField<String>(
                          dropdownColor: Theme.of(context).colorScheme.surface,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                          value: selectedParameterId,
                          decoration: const InputDecoration(
                            labelText: 'Select category',
                            border: OutlineInputBorder(),
                          ),
                          items: widget.parameters.map((item) {
                            return DropdownMenuItem(
                              value: item.id,
                              child: Row(
                                children: [
                                  Container(
                                    width: 28,
                                    height: 28,
                                    color: item.color,
                                  ),
                                  const SizedBox(width: 9),
                                  Text(item.parameterName),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedParameterId = value;
                            });
                          },
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          height: 35,
                          child: ElevatedButton(
                            onPressed: saveSupply,
                            child: const Text('Save'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
