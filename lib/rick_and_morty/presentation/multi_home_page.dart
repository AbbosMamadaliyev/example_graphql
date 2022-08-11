import 'package:flutter/material.dart';
import 'characters/characters_page.dart';
import 'episodes/episodes_page.dart';
import 'locations/locations_page.dart';

class MultiHomePage extends StatefulWidget {
  const MultiHomePage({Key? key}) : super(key: key);

  @override
  State<MultiHomePage> createState() => _MultiHomePageState();
}

class _MultiHomePageState extends State<MultiHomePage> {
  List<Widget>? bodies;
  int currentIndex = 0;

  @override
  initState() {
    super.initState();
    bodies = [
      CharactersPage(),
      EpisodesPage(),
      LocationsPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodies![currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Characters',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_movies),
            label: 'Episodes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Locations',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
