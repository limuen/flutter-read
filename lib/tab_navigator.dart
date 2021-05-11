import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'content_pager.dart';
// 底部导航框架搭建
class TabNavigator extends StatefulWidget {
  const TabNavigator({Key key}) : super(key: key);

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;

  final ContentPageController _contentPageController = ContentPageController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container (
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xffedeef0),
            Color(0xffedeef0),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
          )
        ), // 描述当前容器样式
        child: ContentPager(
          // 点击tab控制内容pageView的联动
          contentPageController: _contentPageController,
          // 滑动内容pageView控制外部tab的联动
          onPageChanged: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ), // 中间内容组件
        // child: Center(
        //   child: Text('你点击了第$_currentIndex个Tab', style: TextStyle(fontSize: 36, color: Colors.blue),),
        // ),
      ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) {
            // tab点击控制pageView联动
            _contentPageController.jumpToPage(index);
            // 修改当前页面的index
            setState(() {
              _currentIndex= index;
            });
          },
          type: BottomNavigationBarType.fixed,
          // selectedFontSize: 14, // active默认字号14
          unselectedFontSize: 14, // 字体大小，源码显示active的是14，所以重新设置14
          items: [
          _bottomItem('本周', Icons.folder, 0),
          _bottomItem('分享', Icons.explore, 1),
          _bottomItem('免费', Icons.donut_small, 2),
          _bottomItem('长按', Icons.person, 3),
        ],)// 底部tab栏
    );
  }
  // 封装底部Tab
  // 传title icon index
  _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
      title: Text(title, style: TextStyle(color: _currentIndex != index ? _defaultColor : _activeColor),),
      icon: Icon(
        icon,
        color: _defaultColor,
      ),
      activeIcon: Icon(
        icon,
        color: _activeColor,
      ),

    );
  }
}
