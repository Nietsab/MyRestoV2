import 'package:shopping_cart/shopping_cart.dart';

class FoodCardModel extends ItemModel {
    late final String name;
    late final String image;

    FoodCardModel({
        required this.name,
        required this.image,

        required super.id,
        required super.price,
        super.quantity = 1,
    });

    @override
    List<Object?> get props => [name,image];
}