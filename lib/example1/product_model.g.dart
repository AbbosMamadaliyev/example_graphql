// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      products: Products.fromJson(json['products'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'products': instance.products.toJson(),
    };

Products _$ProductsFromJson(Map<String, dynamic> json) => Products(
      edges: (json['edges'] as List<dynamic>)
          .map((e) => Edges.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductsToJson(Products instance) => <String, dynamic>{
      'edges': instance.edges.map((e) => e.toJson()).toList(),
    };

Edges _$EdgesFromJson(Map<String, dynamic> json) => Edges(
      node: Node.fromJson(json['node'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EdgesToJson(Edges instance) => <String, dynamic>{
      'node': instance.node.toJson(),
    };

Node _$NodeFromJson(Map<String, dynamic> json) => Node(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$NodeToJson(Node instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
