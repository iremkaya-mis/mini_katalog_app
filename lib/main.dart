import 'package:flutter/material.dart';

void main() {
  runApp(const MiniKatalogApp());
}

class Product {
  final String name;
  final String category;
  final String price;
  final String description;
  final String imageUrl;

  const Product({
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.imageUrl,
  });
}

class MiniKatalogApp extends StatefulWidget {
  const MiniKatalogApp({super.key});

  @override
  State<MiniKatalogApp> createState() => _MiniKatalogAppState();
}

class _MiniKatalogAppState extends State<MiniKatalogApp> {
  int cartCount = 0;

  final List<Product> products = const [
    Product(
      name: "Koşu Ayakkabısı",
      category: "Ayakkabı",
      price: "2.499 TL",
      description:
          "Hafif yapısı ve rahat tabanı ile günlük koşu ve antrenmanlar için uygundur.",
      imageUrl: "https://images.unsplash.com/photo-1542291026-7eec264c27ff",
    ),
    Product(
      name: "Dumbbell Seti",
      category: "Fitness",
      price: "899 TL",
      description:
          "Evde kuvvet antrenmanı yapmak isteyen kullanıcılar için ideal ekipmandır.",
      imageUrl: "https://images.unsplash.com/photo-1517836357463-d25dfeac3438",
    ),
    Product(
      name: "Boks Eldiveni",
      category: "Boks",
      price: "1.299 TL",
      description:
          "Boks ve kickboks antrenmanlarında el bileğini destekleyen dayanıklı eldiven.",
      imageUrl: "https://images.unsplash.com/photo-1517438322307-e67111335449",
    ),
    Product(
      name: "Spor Saat",
      category: "Aksesuar",
      price: "3.799 TL",
      description:
          "Antrenman süresi, kalori ve aktivite takibi için kullanılabilecek spor saat.",
      imageUrl: "https://images.unsplash.com/photo-1523275335684-37898b6baf30",
    ),
    Product(
      name: "Yoga Matı",
      category: "Yoga",
      price: "599 TL",
      description:
          "Kaymaz yüzeyi sayesinde yoga, pilates ve esneme egzersizlerinde rahat kullanım sağlar.",
      imageUrl: "https://images.unsplash.com/photo-1601925260368-ae2f83cf8b7f",
    ),
    Product(
      name: "Spor Çantası",
      category: "Aksesuar",
      price: "749 TL",
      description:
          "Geniş iç hacmi ile spor salonu ve günlük kullanım için uygun bir çantadır.",
      imageUrl: "https://images.unsplash.com/photo-1553062407-98eeb64c6a62",
    ),
  ];

  void addToCart() {
    setState(() {
      cartCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mini Katalog Uygulaması",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: HomePage(
        products: products,
        cartCount: cartCount,
        onAddToCart: addToCart,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Product> products;
  final int cartCount;
  final VoidCallback onAddToCart;

  const HomePage({
    super.key,
    required this.products,
    required this.cartCount,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FitStore Mini Katalog"),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                "Sepet: $cartCount",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Spor Ürünleri Kataloğu",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Fitness, koşu ve boks ürünlerini incele.",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final product = products[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(
                          product: product,
                          onAddToCart: onAddToCart,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(18),
                            ),
                            child: Image.network(
                              product.imageUrl,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            product.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            product.price,
                            style: const TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const ProductDetailPage({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Image.network(
              product.imageUrl,
              height: 280,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            product.name,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.category,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            product.price,
            style: const TextStyle(
              color: Colors.deepOrange,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            product.description,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () {
              onAddToCart();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${product.name} sepete eklendi."),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart),
            label: const Text("Sepete Ekle"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}