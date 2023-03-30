import 'package:flutter/material.dart';
import 'bloc/asbeza_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asbeza/views/history.dart';
import 'package:asbeza/views/home.dart';
import 'package:asbeza/views/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

//static const String _title = 'Sample';
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => AsbezaBloc(),
      child: const MaterialApp(
        title: 'hi',
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _Index = 0;

  void _onItemTapped(int index) {
    setState(() {
      _Index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget child = const Home();
    switch (_Index) {
      case 0:
        child = const MyHistoryPage();
        break;
      case 1:
        child = const Home();
        break;
      case 2:
        child = const MyProfilePage();
        break;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 104, 23, 100),
        title: const Text('አሰቤዛዎ'),
      ),
      body: Center(child: child //_widgetOptions.elementAt(_Index),
          ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_rounded),
            label: 'Profile',
          ),
        ],
        currentIndex: _Index,
        selectedItemColor: const Color.fromARGB(255, 223, 65, 117),
        onTap: _onItemTapped,
      ),
    );
  }
}



     


        

