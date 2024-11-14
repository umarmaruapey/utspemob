import 'package:flutter/material.dart';

class GalonMenuScreen extends StatefulWidget {
  @override
  _GalonMenuScreenState createState() => _GalonMenuScreenState();
}

class _GalonMenuScreenState extends State<GalonMenuScreen> {
  final List<Map<String, dynamic>> allGalonTypes = [
    {
      'name': 'Galon Aqua',
      'capacity': '19 Liter',
      'description': 'Air minum premium dengan mineral seimbang',
      'image': 'assets/galon1.png',
      'price': 'Rp 22.000',
      'rating': 4.8,
      'sales': '1.2k'
    },
    {
      'name': 'Galon Le Mineral',
      'capacity': '15 Liter',
      'description': 'Air minum mineral alami dari pegunungan',
      'image': 'assets/galon2.png',
      'price': 'Rp 20.000',
      'rating': 4.7,
      'sales': '980'
    },
    {
      'name': 'Galon Montoya',
      'capacity': '19 Liter',
      'description': 'Air minum dengan pH tinggi untuk kesehatan optimal',
      'image': 'assets/galon3.png',
      'price': 'Rp 21.000',
      'rating': 4.6,
      'sales': '850'
    },
    {
      'name': 'Galon VIT',
      'capacity': '19 Liter',
      'description': 'Air minum dengan kandungan oksigen tinggi',
      'image': 'assets/galon4.png',
      'price': 'Rp 19.000',
      'rating': 4.5,
      'sales': '750'
    },
  ];

  List<Map<String, dynamic>> filteredGalonTypes = [];
  TextEditingController searchController = TextEditingController();
  String selectedCategory = 'Semua';

  @override
  void initState() {
    super.initState();
    filteredGalonTypes = allGalonTypes;
    searchController.addListener(_filterGalonList);
  }

  void _filterGalonList() {
    String searchTerm = searchController.text.toLowerCase();
    setState(() {
      filteredGalonTypes = allGalonTypes.where((galon) {
        return galon['name'].toLowerCase().contains(searchTerm) ||
            galon['description'].toLowerCase().contains(searchTerm);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF7CC8F8),
              Color(0xFF2196F3),
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
              child: Column(
                children: [
                  // Header Section
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pilih Galon',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              Text(
                                'Temukan galon terbaik untuk Anda',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.notifications_outlined,
                                color: Colors.white),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Search Bar
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: searchController,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Cari jenis galon...',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xFF2196F3),
                            size: 24,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Category Chips
                  SizedBox(
                    height: 45,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      children: [
                        _buildEnhancedChip('Semua', '🌊'),
                        _buildEnhancedChip('Premium', '✨'),
                        _buildEnhancedChip('Regular', '💧'),
                        _buildEnhancedChip('Hemat', '💰'),
                      ],
                    ),
                  ),

                  // Grid View
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 10,
                        bottom: 0,
                      ),
                      child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                        ),
                        itemCount: filteredGalonTypes.length,
                        itemBuilder: (context, index) {
                          final galon = filteredGalonTypes[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 15,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {},
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFE3F2FD),
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20),
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: Image.asset(
                                                galon['image'],
                                                height: 100,
                                                fit: BoxFit.contain,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Icon(
                                                    Icons.water_drop_rounded,
                                                    color: Color(0xFF2196F3),
                                                    size: 40,
                                                  );
                                                },
                                              ),
                                            ),
                                            Positioned(
                                              top: 8,
                                              right: 8,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 6,
                                                  vertical: 3,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF2196F3)
                                                      .withOpacity(0.9),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  galon['capacity'],
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              galon['name'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.black87,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 2),
                                            Row(
                                              children: [
                                                Icon(Icons.star,
                                                    color: Colors.amber,
                                                    size: 14),
                                                SizedBox(width: 2),
                                                Text(
                                                  galon['rating'].toString(),
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 11,
                                                  ),
                                                ),
                                                Text(
                                                  ' • ${galon['sales']} terjual',
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 11,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            Text(
                                              galon['price'],
                                              style: TextStyle(
                                                color: Color(0xFF2196F3),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedChip(String label, String emoji) {
    bool isSelected = selectedCategory == label;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              selectedCategory = label;
            });
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ]
                  : [],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(emoji, style: TextStyle(fontSize: 16)),
                SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? Color(0xFF2196F3) : Colors.white,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
