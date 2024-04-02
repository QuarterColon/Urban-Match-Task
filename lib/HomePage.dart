import 'package:flutter/material.dart';
import 'package:urban_match_task/Screens/RepoPage.dart';
import 'package:urban_match_task/Widgets/appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<Widget> screens = [
    RepoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(),
        body: screens[0],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xff121212),
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          onTap: (index) => setState(() {
            selectedIndex = index;
          }),
          currentIndex: selectedIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.book_outlined), label: "Repos"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
          ],
        ),
      ),
    );
  }
}
