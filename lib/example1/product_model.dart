import 'package:json_annotation/json_annotation.dart';
part 'product_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductModel {
  final Products products;

  ProductModel({required this.products});

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Products {
  final List<Edges> edges;

  Products({required this.edges});

  factory Products.fromJson(Map<String, dynamic> json) =>
      _$ProductsFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Edges {
  final Node node;

  Edges({required this.node});

  factory Edges.fromJson(Map<String, dynamic> json) => _$EdgesFromJson(json);

  Map<String, dynamic> toJson() => _$EdgesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Node {
  final String id;
  final String name;
  final String description;

  Node({required this.id, required this.name, required this.description});

  factory Node.fromJson(Map<String, dynamic> json) => _$NodeFromJson(json);

  Map<String, dynamic> toJson() => _$NodeToJson(this);
}
