import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContentPager extends StatefulWidget {
  // 回调方法 当前内部发生变化的时候 能够及时回调外部调用 （内部调用外部）
  // 内部调用外部 滑动内容pageView控制外部tab的联动
  final ValueChanged<int> onPageChanged;
  // 外部调用内部 点击tab控制内容pageView的联动
  final ContentPageController contentPageController;
  // flutter构造方法 可选参数
  const ContentPager(
      {Key key, this.onPageChanged, this.contentPageController})
      // 类的初始化列表
      : super(key: key);

  @override
  _ContentPagerState createState() => _ContentPagerState();
}

class _ContentPagerState extends State<ContentPager> {
  // 创建pageView实例来改变pageView的宽度
  PageController _pageController = PageController(
    // 视窗比例
      viewportFraction: 0.8
  );

  static List<Color> _colors = [
    Colors.blue,
    Colors.red,
    Colors.deepOrange,
   Colors.teal,
  ];

  void initState() {
    if(widget.contentPageController != null) {
      widget.contentPageController._pageController = _pageController;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // appBar
        
        // 
        Expanded(
          // 高度撑开，否则在Column中没有高度会报错
         child: PageView(
           // widget.onPageChanged 代表的就是State<ContentPager> 所以.就能获取到里面的方法
           // 也就是说上边类ContentPager里面的东西 都可以在这Widget里面用widget调用
          onPageChanged: widget.onPageChanged,
          controller: _pageController,
          children: <Widget>[
            _warpItem(0),
            _warpItem(1),
            _warpItem(2),
            _warpItem(3)
          ],
        ))
      ],
    );
  }
  
  Widget _warpItem(int index) {
    return Padding(padding: EdgeInsets.all(10),
      child: Container(decoration: BoxDecoration(color: _colors[index]),),
    );
  }
}


// 内容区域的控制器
class ContentPageController {
  PageController _pageController;
  void jumpToPage(int page) {
    // dart 编程技巧： 安全的调用
    _pageController?.jumpToPage(page);
  }
}