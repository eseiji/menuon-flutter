import 'package:flutter/material.dart';

class Product {
  final String image, title;
  final String description;
  final int? price, size, id;
  final Color? color;
  Product({
    this.id,
    required this.image,
    required this.title,
    this.price,
    required this.description,
    this.size,
    this.color,
  });
}

List<Product> products = [
  Product(
      id: 1,
      title: "Office Code",
      price: 234,
      size: 12,
      description: dummyText,
      image: "../assets/images/simples.jpg",
      color: Color(0xFF3D82AE)),
  Product(
      id: 2,
      title: "Batata frita",
      price: 23,
      size: 8,
      description: dummyText,
      image: "assets/images/simples.jpg",
      color: Color(0xFFD3A984)),
  Product(
      id: 3,
      title: "Hang Top",
      price: 234,
      size: 10,
      description: dummyText,
      image: "assets/images/simples.jpg",
      color: Color(0xFF989493)),
  Product(
      id: 4,
      title: "Old Fashion",
      price: 234,
      size: 11,
      description: dummyText,
      image: "assets/images/simples.jpg",
      color: Color(0xFFE6B398)),
  Product(
      id: 5,
      title: "Office Code",
      price: 234,
      size: 12,
      description: dummyText,
      image: "assets/images/simples.jpg",
      color: Color(0xFFFB7883)),
  Product(
    id: 6,
    title: "Office Code",
    price: 234,
    size: 12,
    description: dummyText,
    image: "assets/images/simples.jpg",
    color: Color(0xFFAEAEAE),
  ),
];

String dummyText = "TESTE";
