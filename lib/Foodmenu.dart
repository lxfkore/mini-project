import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'La Place Café',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FoodMenuPage(),
    );
  }
}

class FoodMenuPage extends StatefulWidget {
  @override
  _FoodMenuPageState createState() => _FoodMenuPageState();
}

class _FoodMenuPageState extends State<FoodMenuPage> {
  final ScrollController _scrollController = ScrollController();
  String _selectedCategory = 'Main Course';
  Map<String, int> _cart = {}; // Track quantities of each item

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int totalItems = _cart.values.fold(0, (sum, quantity) => sum + quantity);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.menu, color: Colors.white),
                    onPressed: () {},
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle cart icon tap (e.g., navigate to cart page)
                    },
                    child: Stack(
                      children: [
                        Icon(Icons.shopping_cart, color: Colors.white, size: 30),
                        if (totalItems > 0)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.orange,
                              radius: 12,
                              child: Text(
                                '$totalItems',
                                style: TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Food Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Find your pastry...',
                  hintStyle: TextStyle(color: Colors.white54),
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMenuCategory('Main Course'),
                  _buildMenuCategory('Pastries'),
                  _buildMenuCategory('Desserts'),
                  _buildMenuCategory('Caffeine'),
                  _buildMenuCategory('Add Ons'),
                ],
              ),
              SizedBox(height: 16),
              Expanded(
                child: _selectedCategory == 'Main Course'
                    ? SingleChildScrollView(
                  child: Column(
                    children: _getFoodItemsForCategory(_selectedCategory),
                  ),
                )
                    : ListView(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  children: _getFoodItemsForCategory(_selectedCategory),
                ),
              ),
              SizedBox(height: 16),
              _buildSpecialOffer(),
              SizedBox(height: 16),
              _buildBottomNavigationBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCategory(String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = title;
        });
      },
      child: Text(
        title,
        style: TextStyle(
          color: _selectedCategory == title ? Colors.orange : Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  List<Widget> _getFoodItemsForCategory(String category) {
    switch (category) {
      case 'Pastries':
        return [
          _buildFoodCard(
            'Croissant',
            'Buttery and flaky',
            'RM5',
            'assets/croissant.jpg', // Replace with your image asset
          ),
          // Add more pastries here
        ];
      case 'Desserts':
        return [
          _buildFoodCard(
            'Cheesecake',
            'Rich and creamy',
            'RM8',
            'assets/cheesecake.jpg', // Replace with your image asset
          ),
          // Add more desserts here
        ];
      case 'Caffeine':
        return [
          _buildFoodCard(
            'Espresso',
            'Strong and bold',
            'RM7',
            'assets/espresso.jpg', // Replace with your image asset
          ),
          _buildFoodCard(
            'Latte',
            'Smooth and creamy',
            'RM9',
            'assets/latte.jpg', // Replace with your image asset
          ),
          // Add more caffeine items here
        ];
      case 'Add Ons':
        return [
          _buildFoodCard(
            'Extra Cheese',
            'Add extra cheese to your dish',
            'RM2',
            'assets/extra_cheese.jpg', // Replace with your image asset
          ),
          // Add more add-ons here
        ];
      case 'Main Course':
        return [
          _buildFoodCard(
            'Aglio Olio',
            'With Tomatoes',
            'RM9.5',
            'assets/aglio_olio.jpg', // Replace with your image asset
          ),
          _buildFoodCard(
            'Spaghetti',
            'With Meatballs',
            'RM10',
            'assets/spaghetti.jpg', // Replace with your image asset
          ),
          _buildFoodCard(
            'Pizza with Tuna',
            'Delicious tuna pizza',
            'RM10',
            'assets/pizza_tuna.jpg', // Replace with your image asset
          ),
        ];
      default:
        return [];
    }
  }

  Widget _buildFoodCard(String title, String subtitle, String price, String imagePath) {
    int quantity = _cart[title] ?? 0;

    return Container(
      margin: EdgeInsets.only(right: 16),
      width: 150,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(imagePath, fit: BoxFit.cover, height: 100, width: double.infinity),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: TextStyle(color: Colors.orange, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        if (quantity > 0)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'x$quantity',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        IconButton(
                          icon: Icon(Icons.add, color: Colors.orange),
                          onPressed: () {
                            setState(() {
                              _cart[title] = (quantity + 1);
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialOffer() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.local_offer, color: Colors.orange, size: 32),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              'Special Offer at LaPlace right now!',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    int totalItems = _cart.values.fold(0, (sum, quantity) => sum + quantity);

    return BottomNavigationBar(
      backgroundColor: Colors.black,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.white),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Stack(
            children: [
              Icon(Icons.shopping_cart, color: Colors.white),
              if (totalItems > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: CircleAvatar(
                    backgroundColor: Colors.orange,
                    radius: 12,
                    child: Text(
                      '$totalItems',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, color: Colors.white),
          label: 'Profile',
        ),
      ],
    );
  }
}
