import 'package:bit_wall/screens/settings_screen.dart';
import 'package:bit_wall/screens/wallpapers_screen.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentIndex = 0;

  bool searchBar = false;
  final List _homePages = [
    const WallpapersScreen(
      searchText: '',
    ),
    const Text("data2"),
    const SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            searchBar
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _homePages[0] = WallpapersScreen(searchText: value);
                        });
                      },
                    ),
                  )
                : const SizedBox(),
            _homePages.elementAt(_currentIndex),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavBar(),
    );
  }

  AppBar customAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      title: const Text(
        "Bit-Wall",
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      actions: [
        _currentIndex != 3
            ? IconButton(
                icon: const Icon(
                  Icons.search,
                ),
                onPressed: () {
                  setState(() {
                    searchBar ? searchBar = false : searchBar = true;
                  });
                },
              )
            : Icon(null)
      ],
    );
  }

  SalomonBottomBar bottomNavBar() {
    return SalomonBottomBar(
      currentIndex: _currentIndex,
      onTap: (i) => setState(() => _currentIndex = i),
      items: [
        SalomonBottomBarItem(
          icon: const Icon(
            Icons.wallpaper_outlined,
          ),
          title: const Text(
            "Wallpapers",
          ),
          selectedColor: Colors.purple,
        ),
        SalomonBottomBarItem(
          icon: const Icon(
            Icons.favorite_border,
          ),
          title: const Text(
            "Likes",
          ),
          selectedColor: Colors.orange,
        ),
        SalomonBottomBarItem(
          icon: const Icon(
            Icons.settings_outlined,
          ),
          title: const Text(
            "Settings",
          ),
          selectedColor: Colors.teal,
        ),
      ],
    );
  }
}
