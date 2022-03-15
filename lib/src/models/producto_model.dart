// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

ProductoModel productoModelFromJson(String str) => ProductoModel.fromJson(json.decode(str));

String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
    ProductoModel({
        this.id,
        this.titulo= 'A',
        this.autor= 'B',
        this.edicion= 12,
    });
    int id;
    String titulo;
    String autor;
    int edicion;

    factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        id: json["id"],
        titulo: json["titulo"],
        autor: json["autor"],
        edicion: json["edicion"],
    );

    Map<String, dynamic> toJson() => {
        // "id": id,
        "titulo": titulo,
        "autor": autor,
        "edicion": edicion,
    };
}
