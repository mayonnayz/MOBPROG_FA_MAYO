import 'package:fa4_reverse_engineering/model/parameter.dart';

class ItemSupply {
  final String id;
  final String name;
  final int quantity;
  final double price;
  final Parameter parameter;

  const ItemSupply({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.parameter,
  });
}