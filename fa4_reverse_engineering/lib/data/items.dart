import 'package:fa4_reverse_engineering/data/parameters.dart';
import 'package:fa4_reverse_engineering/model/item_supply.dart';

var items = [
  ItemSupply(
    id: '1', 
    name: 'Katana',
    parameter: parameters[0],
    price: 35.00,
    quantity: 5,
  ),
  ItemSupply(
    id: '2', 
    name: 'Shotgun',
    parameter: parameters[1],
    price: 150.00,
    quantity: 5,
  ),
  ItemSupply(
    id: '3', 
    name: 'Nail Bomb',
    parameter: parameters[2],
    price: 5.00,
    quantity: 50,
  ),
  ItemSupply(
    id: '4', 
    name: 'Molotov Cocktail',
    parameter: parameters[2],
    price: 10.00,
    quantity: 50,
  ),
  ItemSupply(
    id: '5', 
    name: 'Med Kit',
    parameter: parameters[3],
    price: 25.00,
    quantity: 20,
  ),
  ItemSupply(
    id: '6', 
    name: 'Bandage',
    parameter: parameters[3],
    price: 10.00,
    quantity: 100,
  ),
  ItemSupply(
    id: '7', 
    name: 'Body Armor',
    parameter: parameters[4],
    price: 50.00,
    quantity: 30,
  ),
];