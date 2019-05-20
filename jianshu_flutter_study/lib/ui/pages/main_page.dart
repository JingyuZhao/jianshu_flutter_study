import 'package:flutter/material.dart';
import 'package:jianshu_flutter_study/common/component_index.dart';
import 'package:jianshu_flutter_study/ui/pages/main_left_page.dart';
import 'package:jianshu_flutter_study/ui/pages/page_index.dart';

class _Page {
  final String labelId;
  _Page(this.labelId);
}

final List<_Page> _allPages = <_Page>[
  _Page(Ids.titleHome),
  _Page(Ids.titleRepos),
  _Page(Ids.titleEvents),
  _Page(Ids.titleSystem)
];

class MainPage extends StatelessWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _allPages.length,
      child: Scaffold(
        appBar: MyAppBar(
          leading: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage(Utils.getImgPath("ali_connors")))),
          ),
          centerTitle: true,
          title: TabLayout(),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                NavigatorUtil.pushPages(context, SearchPage(),
                    pageName: "SearchPage");
              },
            )
          ],
        ),
        body: TabBarViewLayout(),
        drawer: Drawer(
          child: MainLeftPage(),
        ),
      ),
    );
  }
}

class TabLayout extends StatelessWidget {
  const TabLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      labelPadding: EdgeInsets.all(12.0),
      indicatorSize: TabBarIndicatorSize.label,
      tabs: _allPages.map((_Page page) {
        return Tab(
          text: IntlUtil.getString(context, page.labelId),
        );
      }).toList(),
    );
  }
}

class TabBarViewLayout extends StatelessWidget {
  Widget buildTabView(BuildContext context, _Page page) {
    String labelId = page.labelId;
    switch (labelId) {
      case Ids.titleHome:
        return HomePage(labelId: labelId);
        break;
      case Ids.titleRepos:
        return ReposPage(labelId: labelId);
        break;
      case Ids.titleEvents:
        return EventsPage(labelId: labelId);
        break;
      case Ids.titleSystem:
        return SystemPage(labelId: labelId);
        break;
      default:
        return Container();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    LogUtil.e("TabBarViewLayout build.......");
    return new TabBarView(
        children: _allPages.map((_Page page) {
      return buildTabView(context, page);
    }).toList());
  }
}
