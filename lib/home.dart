import 'package:flutter/material.dart';
import 'package:flutter_event_bus/pages/page_a.dart';
import 'package:flutter_event_bus/pages/page_b.dart';
import 'package:flutter_event_bus/pages/page_c.dart';
import 'package:flutter_event_bus/pages/page_d.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
    BottomNavigationBarItem(icon: Icon(Icons.category), title: Text('分类')),
    BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart), title: Text('购物车')),
    BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('我的'))
  ];

  final List<Widget> tabBodies = [
    PageA(),
    PageB(),
    PageC(),
    PageD(),
  ];

  int currentIndex = 0;
  PageController pageController;

  var currentPage;

  void initState() {
    currentPage = tabBodies[currentIndex];
    this.pageController =
        PageController(initialPage: currentIndex, keepPage: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: currentPage,
      body: PageView(
        children: tabBodies,
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index) {
          setState(() {
            // currentIndex = index;
            // currentPage = tabBodies[index];
            currentIndex = index;
            pageController.jumpToPage(index);
          });
        },
      ),
    );
  }
}
