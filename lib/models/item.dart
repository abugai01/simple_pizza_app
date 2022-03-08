import 'package:simple_pizza_app/helpers/functions.dart';

//TODO: short version to include in order
class Item {
  static const ID = 'id';
  static const NAME = 'name';
  static const CATEGORY = 'category'; //todo: how is it used?
  static const DESCRIPTION = 'description';
  static const INGREDIENTS = 'ingredients';
  static const CALORIES = 'calories';
  static const SIZE = 'size';
  static const WEIGHT = 'weight';
  static const IS_AVAILABLE = 'isAvailable';
  static const IMAGE = 'image';
  static const PRICE = 'price';
  static const QUANTITY = 'quantity';

  String id;
  String name;
  String? category; //TODO: maybe a list
  String description;
  String ingredients;
  num? calories; //todo null safety ?? 0
  num? size;
  num? weight;
  bool? isAvailable;
  String image;
  num price;
  int quantity;
  bool
      isNull; //todo: maybe should be like auto id class available for all by default!

  Item({
    required this.id,
    required this.name,
    this.category,
    required this.description,
    required this.ingredients,
    this.calories,
    this.size,
    this.weight,
    this.isAvailable,
    required this.image,
    required this.price,
    required this.quantity,
    this.isNull = false,
  });

  static fromMap(Map<String, dynamic>? data, String documentId) {
    return Item(
      id: documentId,
      name: data?[NAME] ?? '',
      category: data?[CATEGORY],
      description: data?[DESCRIPTION] ?? '',
      ingredients: data?[INGREDIENTS] ?? '',
      calories: data?[CALORIES],
      size: data?[SIZE],
      weight: data?[WEIGHT],
      isAvailable: data?[IS_AVAILABLE], //todo: should it be here??
      image: data?[IMAGE] ?? '',
      price: data?[PRICE] ?? 0,
      quantity: data?[QUANTITY] ?? 1,
      isNull: data == null ? true : false, //todo: think more!
    );
  }

  Map<String, dynamic> toMap() {
    return {
      ID: id,
      NAME: name,
      IMAGE: image,
      PRICE: price,
      QUANTITY: quantity,
    };
  }

  //Getters
  String get priceFormatted => formatWithCurrency(price, fractionDigits: 2);
  String get priceFormattedShort =>
      formatWithCurrency(price, fractionDigits: 0);
  num get subtotal => price * quantity;
  String get subtotalFormatted =>
      formatWithCurrency(subtotal, fractionDigits: 2);
}
