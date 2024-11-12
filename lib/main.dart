import 'package:flutter/material.dart';
import 'package:sale/pages/home.dart';
import 'package:sale/pages/report.dart';
import 'package:sale/pages/sales_entry.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UNITI ASIA SALES REPORT',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 1;

  static const List<Widget> _pages = <Widget>[
    SalesEntryPage(),
    HomePage(),
    ReportPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade100,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0), // Adjust padding if needed
          child: Image.asset(
            'assets/logo.png', // Path to your logo image
            height: 20, // Adjust the size as needed
          ),
        ),
        title: const Text(
          'UNITI ASIA SALES REPORT',
          style: TextStyle(color: Colors.white70, fontSize: 15),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 122, 23, 23),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            color: Colors.white70,
            onPressed: () {
              // Handle add button press
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            color: Colors.white70,
            onPressed: () {
              // Handle profile button press
            },
          ),
        ],
      ),
      body: SafeArea(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_document),
            label: 'Sales',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_rounded),
            label: 'Sales Report',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
