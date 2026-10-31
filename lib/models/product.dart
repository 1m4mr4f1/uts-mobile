import 'package:flutter/material.dart';

class Product {
  const Product({
    required this.name,
    required this.description,
    required this.price,
    required this.emoji,
    required this.color,
    required this.imageAsset,
  });

  final String name;
  final String description;
  final int price;
  final String emoji;
  final Color color;
  final String imageAsset;
}

const productCatalog = [
  Product(
    name: 'Es Teh Ajib',
    description: 'Teh pilihan yang diseduh segar, manis, dan menyegarkan.',
    price: 5000,
    emoji: '🧋',
    color: Color(0xFFFFE7C2),
    imageAsset: 'assets/esteh.jpg',
  ),
  Product(
    name: 'Lumpia',
    description: 'Lumpia renyah dengan isian gurih, cocok untuk teman santai.',
    price: 3000,
    emoji: '🥟',
    color: Color(0xFFFFE8D8),
    imageAsset: 'assets/lumpia.jpg',
  ),
  Product(
    name: 'Pisang Goreng',
    description: 'Pisang pilihan digoreng hangat dengan balutan tepung renyah.',
    price: 2500,
    emoji: '🍌',
    color: Color(0xFFFFF1BE),
    imageAsset: 'assets/pisanggoreng.png',
  ),
  Product(
    name: 'Tahu Bakso',
    description: 'Tahu isi bakso yang gurih dan nikmat disantap selagi hangat.',
    price: 4000,
    emoji: '🍢',
    color: Color(0xFFF8DFD9),
    imageAsset: 'assets/tahubakso.jpg',
  ),
  Product(
    name: 'Jajanan Pasar',
    description: 'Pilihan jajanan pasar sederhana untuk menemani harimu.',
    price: 2000,
    emoji: '🍡',
    color: Color(0xFFF4DFF1),
    imageAsset: 'assets/jajananpasar.jpg',
  ),
  Product(
    name: 'Es Jeruk',
    description: 'Minuman jeruk segar dengan rasa manis dan sedikit asam.',
    price: 6000,
    emoji: '🍊',
    color: Color(0xFFFFE2D2),
    imageAsset: 'assets/esjeruk.jpg',
  ),
];
