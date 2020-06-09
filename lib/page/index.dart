import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_template/generated/i18n.dart';
import 'package:my_flutter_template/utils/click.dart';
import 'package:my_flutter_template/utils/provider.dart';
import 'package:provider/provider.dart';

class MainHomePage extends StatefulWidget {
  MainHomePage({Key key}) : super(key: key);
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  List<BottomNavigationBarItem> getTabs(BuildContext context) => [
        BottomNavigationBarItem(
            title: Text(I18n.of(context).home), icon: Icon(Icons.home)),
        BottomNavigationBarItem(
            title: Text(I18n.of(context).category), icon: Icon(Icons.list)),
        BottomNavigationBarItem(
            title: Text(I18n.of(context).activity), icon: Icon(Icons.local_activity)),
        BottomNavigationBarItem(
            title: Text(I18n.of(context).message), icon: Icon(Icons.notifications)),
        BottomNavigationBarItem(
            title: Text(I18n.of(context).profile), icon: Icon(Icons.person)),
      ];
  
  List<Widget> getTabWidget(BuildContext context)  => [
    Center(child: Text(I18n.of(context).home)),
    Center(child: Text(I18n.of(context).category)),
    Center(child: Text(I18n.of(context).activity)),
    Center(child: Text(I18n.of(context).message)),
    Center(child: Text(I18n.of(context).profile))
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  @override
  void initState() {
    super.initState();
    // 强制更新
    // TODO:

  }
  Widget build(BuildContext context) {
    var tabs = getTabs(context);
    return Consumer(
      builder: (BuildContext context, AppStatus status, Widget child) {
        return WillPopScope(
          child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: tabs[status.tabIndex].title,
            ),

            body: IndexedStack(
              index: status.tabIndex,
              children: getTabWidget(context),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: tabs,
              currentIndex: status.tabIndex,
              onTap: (index) {
                status.tabIndex = index;
              },
              type: BottomNavigationBarType.fixed,
              fixedColor: Theme.of(context).primaryColor,
            ),
          ),
          // 监听导航栏返回
          onWillPop: () => ClickUtils.exitBy2Click(status: _scaffoldKey.currentState),
        );
      },
    );
  }
}
