import 'package:flutter/material.dart';
import 'dart:async';
import 'bmi.dart';
import 'kalkulator.dart';
import 'konversi_suhu.dart';
import 'konversi_mata_uang.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _scaleAnimations;
  late List<Animation<double>> _opacityAnimations;
  late String _currentTime;
  late Timer _timer;
  TextEditingController _noteController = TextEditingController();

  // Add dropdown value
  String _selectedCategory = 'Calculator';
  final List<String> _categories = [
    'Calculator',
    'Converter',
    'Health',
    'Finance',
  ];

  // Aqua theme colors
  final Color primaryAqua = Color(0xFF00B4D8);
  final Color lightAqua = Color(0xFF90E0EF);
  final Color darkAqua = Color(0xFF0077B6);
  final Color paleAqua = Color(0xFFCAF0F8);

  @override
  void initState() {
    super.initState();

    _currentTime = _getCurrentTime();
    _timer = Timer.periodic(Duration(seconds: 1), _updateTime);

    _controller = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );

    _scaleAnimations = List.generate(4, (index) {
      return Tween<double>(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(0.1 * index, 1.0, curve: Curves.easeOutBack),
        ),
      );
    });

    _opacityAnimations = List.generate(4, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(0.2 * index, 1.0, curve: Curves.easeIn),
        ),
      );
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
  }

  void _updateTime(Timer timer) {
    setState(() {
      _currentTime = _getCurrentTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: paleAqua,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Kalkulator',
          style: TextStyle(
            color: darkAqua,
            fontSize: 24,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: darkAqua),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              paleAqua,
              Colors.white.withOpacity(0.9),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      primaryAqua,
                      lightAqua,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: primaryAqua.withOpacity(0.3),
                      blurRadius: 15,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Time',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          _currentTime,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        Icons.access_time,
                        color: Colors.white,
                        size: 42,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: primaryAqua.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _noteController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Quick Notes',
                    labelStyle: TextStyle(
                      color: darkAqua,
                      fontWeight: FontWeight.w500,
                    ),
                    hintText: 'Write your thoughts here...',
                    hintStyle: TextStyle(color: lightAqua),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: primaryAqua, width: 2),
                    ),
                    contentPadding: EdgeInsets.all(20),
                  ),
                ),
              ),
              SizedBox(height: 24),

              // Add Dropdown/Spinner
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: primaryAqua.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down, color: darkAqua),
                    style: TextStyle(
                      color: darkAqua,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedCategory = newValue;
                        });
                      }
                    },
                    items: _categories
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          children: [
                            Icon(
                              _getCategoryIcon(value),
                              color: primaryAqua,
                              size: 24,
                            ),
                            SizedBox(width: 12),
                            Text(value),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 24),

              Text(
                'Tools',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: darkAqua,
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  children: List.generate(4, (index) {
                    return AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _opacityAnimations[index].value,
                          child: Transform.scale(
                            scale: _scaleAnimations[index].value,
                            child: _buildCalculatorBox(
                              context,
                              icon: _getIcon(index),
                              title: _getTitle(index),
                              page: _getPage(index),
                              color: _getColor(index),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Add helper method for category icons
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Calculator':
        return Icons.calculate;
      case 'Converter':
        return Icons.swap_horiz;
      case 'Health':
        return Icons.favorite;
      case 'Finance':
        return Icons.attach_money;
      default:
        return Icons.category;
    }
  }

  Color _getColor(int index) {
    List<Color> colors = [
      primaryAqua,
      Color(0xFF48CAE4),
      Color(0xFF00B4D8),
      darkAqua,
    ];
    return colors[index];
  }

  IconData _getIcon(int index) {
    switch (index) {
      case 0:
        return Icons.fitness_center;
      case 1:
        return Icons.calculate_outlined;
      case 2:
        return Icons.thermostat_outlined;
      case 3:
        return Icons.currency_exchange;
      default:
        return Icons.device_unknown;
    }
  }

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return 'BMI\nCalculator';
      case 1:
        return 'Basic\nCalculator';
      case 2:
        return 'Temperature\nConverter';
      case 3:
        return 'Currency\nConverter';
      default:
        return 'Unknown';
    }
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return BmiCalculator();
      case 1:
        return KalkulatorScreen();
      case 2:
        return TemperatureConverter();
      case 3:
        return CurrencyConverter();
      default:
        return Container();
    }
  }

  Widget _buildCalculatorBox(BuildContext context,
      {required IconData icon,
      required String title,
      required Widget page,
      required Color color}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 15,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Positioned(
                right: -20,
                top: -20,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 32,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: darkAqua,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
