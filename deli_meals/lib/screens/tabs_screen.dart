import 'package:flutter/material.dart';

import './categories_screen.dart';
import '../models/meal.dart';
import './favourites_screen.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favouriteMeals;

  TabsScreen(this.favouriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {
        'page': CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': FavouritesScreen(widget.favouriteMeals),
        'title': 'Your Favourites'
      }
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return DefaultTabController(
    //   length: 2,
    //   // initialIndex: 1,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Deli Meals'),
    //       bottom: TabBar(
    //         tabs: <Widget>[
    //           const Tab(icon: const Icon(Icons.category), text: 'Categories'),
    //           const Tab(icon: const Icon(Icons.star), text: 'Favourites'),
    //         ],
    //       ),
    //     ),
    //     body: TabBarView(
    //       children: <Widget>[
    //         CategoriesScreen(),
    //         FavouritesScreen(),
    //       ],
    //     ),
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).accentColor,
          currentIndex: _selectedPageIndex,
          // type: BottomNavigationBarType.fixed, //default value
          items: [
            BottomNavigationBarItem(
              // backgroundColor: Theme.of(context).primaryColor, // needed for shifting type
              icon: const Icon(Icons.category),
              title: const Text('Categories'),
            ),
            BottomNavigationBarItem(
              // backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.star),
              title: const Text('Favourites'),
            ),
          ]),
    );
  }
}
