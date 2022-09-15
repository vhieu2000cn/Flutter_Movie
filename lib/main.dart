import 'dart:math';

import 'package:flutter/material.dart';

import 'pages/AboutScreen.dart';
import 'pages/DrawerScreen.dart';
import 'pages/FavouriteScreen.dart';
import 'pages/HomeScreen.dart';
import 'pages/SettingScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

enum Tab {
  HOME(0, "Movies"),
  FAVOURITE(1, "Favourite"),
  SETTING(2, "Setting"),
  ABOUT(3, "About");

  final int id;
  final String title;

  const Tab(this.id, this.title);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _pageController = PageController();

  int currentTab = Tab.values.first.id;
  double xOffset = 0;
  double yOffset = 0;
  bool isDrawerOpen = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isDrawerOpen) {
          closeDrawer();
          return Future.value(false);
        } else if (false) {
          //check page
        } else {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Do you want to go back?'),
                actionsAlignment: MainAxisAlignment.end,
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text('No'),
                  ),
                ],
              );
            },
          );
          return shouldPop!;
        }
      },
      child: Stack(
        children: [
          const DrawerScreen(),
          AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform: Matrix4.translationValues(xOffset, yOffset, 0)
                ..rotateZ(isDrawerOpen ? pi / 20 : 0)
                ..scale(isDrawerOpen ? 0.8 : 1.00),
              child: mainScreen(context))
        ],
      ),
    );
  }

  Widget mainScreen(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(Tab.values[currentTab].title),
        leading: MaterialButton(
          child: const Icon(Icons.menu),
          onPressed: () {
            handleDrawer(size);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _pageController.animateToPage(Tab.SETTING.index,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeIn);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: PageView(
        onPageChanged: (pageIndex) {
          setState(() {
            currentTab = pageIndex;
          });
        },
        controller: _pageController,
        children:  const [
          HomeScreen(),
          FavouriteScreen(),
          SettingScreen(),
          AboutScreen(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [homeTabItem(), favouriteTabItem()],
              ),
              Row(
                children: [
                  settingTabItem(),
                  aboutTabItem(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget homeTabItem() {
    return MaterialButton(
      onPressed: () {
        _pageController.animateToPage(Tab.HOME.index,
            duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.home,
            color: currentTab == Tab.HOME.index ? Colors.blue : Colors.grey,
          ),
          Text(
            Tab.HOME.title,
            style: TextStyle(
              color: currentTab == Tab.HOME.index ? Colors.blue : Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  Widget favouriteTabItem() {
    return MaterialButton(
      onPressed: () {
        _pageController.animateToPage(Tab.FAVOURITE.index,
            duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite,
            color:
                currentTab == Tab.FAVOURITE.index ? Colors.blue : Colors.grey,
          ),
          Text(
            Tab.FAVOURITE.title,
            style: TextStyle(
              color:
                  currentTab == Tab.FAVOURITE.index ? Colors.blue : Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  Widget settingTabItem() {
    return MaterialButton(
      onPressed: () {
        _pageController.animateToPage(Tab.SETTING.index,
            duration: const Duration(milliseconds: 100),
            curve: Curves.bounceInOut);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.settings,
            color: currentTab == Tab.SETTING.index ? Colors.blue : Colors.grey,
          ),
          Text(
            Tab.SETTING.title,
            style: TextStyle(
              color:
                  currentTab == Tab.SETTING.index ? Colors.blue : Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  Widget aboutTabItem() {
    return MaterialButton(
      onPressed: () {
        _pageController.animateToPage(Tab.ABOUT.index,
            duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.info,
            color: currentTab == Tab.ABOUT.index ? Colors.blue : Colors.grey,
          ),
          Text(
            Tab.ABOUT.title,
            style: TextStyle(
              color: currentTab == Tab.ABOUT.index ? Colors.blue : Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  void handleDrawer(Size size) {
    if (isDrawerOpen) {
      setState(() {
        xOffset = 0;
        yOffset = 0;
        isDrawerOpen = false;
      });
    } else {
      setState(() {
        xOffset = size.width - 120;
        yOffset = size.height / 5;
        isDrawerOpen = true;
      });
    }
  }

  void closeDrawer() {
    if (isDrawerOpen) {
      setState(() {
        xOffset = 0;
        yOffset = 0;
        isDrawerOpen = false;
      });
    }
  }
}
