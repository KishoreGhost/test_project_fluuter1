import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Firstpage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Firstpage> {
  List categories = [];
  List<dynamic> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Fetch categories
      final categoriesResponse = await http.get(
        Uri.parse('https://fakestoreapi.com/products/categories'),
      );
      if (categoriesResponse.statusCode == 200) {
        categories = json.decode(categoriesResponse.body);
      }

      // Fetch products
      final productsResponse = await http.get(
        Uri.parse('https://fakestoreapi.com/products'),
      );
      if (productsResponse.statusCode == 200) {
        products = json.decode(productsResponse.body);
      }
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A2E),
      body: SafeArea(
        child: isLoading ? _buildLoadingShimmer() : _buildMainContent(),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildLoadingShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[900]!,
      highlightColor: Colors.grey[800]!,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildSearchBar(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 20, width: 120, color: Colors.white),
                  SizedBox(height: 16),
                  Row(
                    children: List.generate(
                      5,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Column(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              height: 12,
                              width: 60,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Container(height: 20, width: 120, color: Colors.white),
                  SizedBox(height: 16),
                  Row(
                    children: List.generate(
                      2,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Container(
                          width: 150,
                          height: 220,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    // Group products by category for different sections
    Map<String, List> productsByCategory = {};
    if (categories.isNotEmpty) {
      for (var category in categories) {
        productsByCategory[category] =
            products
                .where((product) => product['category'] == category)
                .toList();
      }
    }

    // Create a list of "new" products (we'll just use the last few products)
    List newProducts =
        products.length > 4 ? products.sublist(products.length - 4) : products;

    // Create a list of "featured" products (we'll just use the first few products)
    List featuredProducts =
        products.length > 3 ? products.sublist(0, 3) : products;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildSearchBar(),
          _buildFeaturedBanner(featuredProducts),
          _buildCategories(categories),
          _buildSectionTitle('Top Selling', onSeeAllTap: () {}),
          _buildProductRow(products),
          _buildSectionTitle('New In', onSeeAllTap: () {}),
          _buildProductRow(newProducts),
          ...categories.map((category) {
            if (productsByCategory[category]?.isNotEmpty ?? false) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(
                    category[0].toUpperCase() + category.substring(1),
                    onSeeAllTap: () {},
                  ),
                  _buildProductRow(productsByCategory[category]!),
                ],
              );
            } else {
              return SizedBox.shrink();
            }
          }).toList(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.grey[800],
            child: ClipOval(
              child: Image.network(
                'https://via.placeholder.com/50',
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) =>
                        Icon(Icons.person, color: Colors.white),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Text(
                  'Men',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 18),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.deepPurple.withOpacity(0.8),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.grey[400]),
            prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedBanner(List featuredProducts) {
    if (featuredProducts.isEmpty) return SizedBox.shrink();

    // Controller for PageView and indicator
    final PageController pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.9,
    );

    return Column(
      children: [
        SizedBox(height: 16),
        Container(
          height: 180,
          child: PageView.builder(
            controller: pageController,
            itemCount: featuredProducts.length,
            itemBuilder: (context, index) {
              final product = featuredProducts[index];
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[850],
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        imageUrl: product['image'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        placeholder:
                            (context, url) => Container(
                              color: Colors.grey[900],
                              child: Center(child: CircularProgressIndicator()),
                            ),
                        errorWidget:
                            (context, url, error) => Container(
                              color: Colors.grey[900],
                              child: Icon(Icons.error),
                            ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 15,
                      left: 15,
                      right: 15,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['title'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            '\$${product['price'].toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10),
        SmoothPageIndicator(
          controller: pageController,
          count: featuredProducts.length,
          effect: ExpandingDotsEffect(
            dotHeight: 8,
            dotWidth: 8,
            expansionFactor: 4,
            dotColor: Colors.grey[600]!,
            activeDotColor: Colors.deepPurple,
          ),
        ),
      ],
    );
  }
}

Widget _buildSectionTitle(String title, {required Function() onSeeAllTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: onSeeAllTap,
          child: Text(
            'See All',
            style: TextStyle(color: Colors.grey[400], fontSize: 14),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCategories(dynamic categories) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('Categories', onSeeAllTap: () {}),
      SizedBox(
        height: 110,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 8),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            String category = categories[index];
            String categoryName =
                category[0].toUpperCase() + category.substring(1);

            // Simulating category images - in a real app, you'd have proper images
            String imageUrl = 'https://via.placeholder.com/150';

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[800],
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        placeholder:
                            (context, url) => Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.grey[700]!,
                                ),
                                strokeWidth: 2,
                              ),
                            ),
                        errorWidget:
                            (context, url, error) =>
                                Icon(Icons.category, color: Colors.grey[600]),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    categoryName.length > 10
                        ? categoryName.substring(0, 10) + '...'
                        : categoryName,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ],
  );
}

Widget _buildProductRow(List products) {
  return SizedBox(
    height: 280,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 8),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            width: 180,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: Container(
                        height: 180,
                        width: double.infinity,
                        color: Colors.white,
                        child: CachedNetworkImage(
                          imageUrl: product['image'],
                          fit: BoxFit.contain,
                          placeholder:
                              (context, url) => Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.grey[700]!,
                                  ),
                                ),
                              ),
                          errorWidget:
                              (context, url, error) =>
                                  Icon(Icons.error, color: Colors.grey[600]),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.favorite_border,
                            size: 18,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['title'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${product['price'].toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 14),
                              SizedBox(width: 2),
                              Text(
                                '${product['rating']?['rate'] ?? 4.5}',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                ),
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
          ),
        );
      },
    ),
  );
}

Widget _buildBottomNavBar() {
  return Container(
    height: 65,
    decoration: BoxDecoration(
      color: Color(0xFF1A1A2E),
      border: Border(top: BorderSide(color: Colors.grey[900]!, width: 0.5)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildNavBarItem(Icons.home, true),
        _buildNavBarItem(Icons.notifications_outlined, false),
        _buildNavBarItem(Icons.receipt_outlined, false),
        _buildNavBarItem(Icons.person_outline, false),
      ],
    ),
  );
}

Widget _buildNavBarItem(IconData icon, bool isActive) {
  return Container(
    width: 60,
    height: 40,
    decoration: BoxDecoration(
      color:
          isActive ? Colors.deepPurple.withOpacity(0.15) : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Icon(
      icon,
      color: isActive ? Colors.deepPurple : Colors.grey,
      size: 24,
    ),
  );
}
