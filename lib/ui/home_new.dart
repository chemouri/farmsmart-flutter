import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/data/bloc/article/ArticleListProvider.dart';
import 'package:farmsmart_flutter/data/repositories/FlameLink.dart';
import 'package:farmsmart_flutter/data/repositories/article/ArticleRepositoryInterface.dart';
import 'package:farmsmart_flutter/data/repositories/article/implementation/ArticlesRepositoryFlamelink.dart';
import 'package:farmsmart_flutter/farmsmart_localizations.dart';
import 'package:farmsmart_flutter/ui/bottombar/persistent_bottom_navigation_bar.dart';
import 'package:farmsmart_flutter/ui/bottombar/tab_navigator.dart';
import 'package:farmsmart_flutter/ui/discover/ArticleList.dart';
import 'package:farmsmart_flutter/ui/playground/data/playground_datasource_impl.dart';
import 'package:farmsmart_flutter/ui/playground/playground_view.dart';
import 'package:flutter/material.dart';

class _Constants {
  static final double bottomBarIconSize = 25;

  static final myPlotSelectedIcon = 'assets/icons/my_plot_selected.png';
  static final myPlotIcon = 'assets/icons/my_plot.png';
  static final profitLossSelectedIcon = 'assets/icons/profit_loss_selected.png';
  static final profitLossIcon = 'assets/icons/profit_loss.png';
  static final discoverSelectedIcon = 'assets/icons/discover_selected.png';
  static final discoverIcon = 'assets/icons/discover.png';
  static final communitySelectedIcon = 'assets/icons/community_selected.png';
  static final communityIcon = 'assets/icons/community.png';
}


final cms = FlameLink(
    store: Firestore.instance, environment: Environment.development);
final articleRepo = ArticlesRepositoryFlameLink(cms);

class Home extends StatelessWidget {

  FarmsmartLocalizations localizations;

  @override
  Widget build(BuildContext context) {
    localizations = FarmsmartLocalizations.of(context);

    return PersistentBottomNavigationBar(
      backgroundColor: Colors.white,
      tabs: tabs(),
    );
  }

  List<TabNavigator> tabs() {
    return [
      _buildTabNavigator(
        //TODO Add My plot screen without redux
        Text('My Plot'),
        _Constants.myPlotSelectedIcon,
        _Constants.myPlotIcon,
      ),
      _buildTabNavigator(
        //TODO Add Profit Loss screen without redux
        Text('Profit Loss'),
        _Constants.profitLossSelectedIcon,
        _Constants.profitLossIcon,
      ),
      _buildTabNavigator(
        //TODO Check Discover screen after rebase LH's opened PR
        _buildDiscover(),
        _Constants.discoverSelectedIcon,
        _Constants.discoverIcon,
      ),
      _buildTabNavigator(
        //TODO Add Community screen without redux
        Text('Community'),
        _Constants.communitySelectedIcon,
        _Constants.communityIcon,
      ),
      _buildTabNavigatorWithCircleImageWidget(
        //TODO Add profile screen
        Text('Profile'),
      ),
      _buildTabNavigator(
        _buildPlayground(),
        _Constants.communitySelectedIcon,
        _Constants.communityIcon,
      ),
    ];
  }

  _buildDiscover() {
    return ArticleList(
        viewModelProvider: ArticleListProvider(
            title: localizations.discoverTab,
            repository: articleRepo,
            group: ArticleCollectionGroup.discovery));
  }

  _buildPlayground(){
    return PlaygroundView(
      widgetList: PlaygroundDataSourceImpl().getList(),
    );
  }

  TabNavigator _buildTabNavigator(Widget page,
      String activeIconPath,
      String iconPath,) {
    return TabNavigator(
      child: page,
      barItem: BottomNavigationBarItem(
        activeIcon: Image.asset(
          activeIconPath,
          height: _Constants.bottomBarIconSize,
        ),
        icon: Image.asset(
          iconPath,
          height: _Constants.bottomBarIconSize,
        ),
        title: SizedBox.shrink(),
      ),
    );
  }

  //TODO Build it properly
  TabNavigator _buildTabNavigatorWithCircleImageWidget(Widget page) {
    return TabNavigator(
      child: page,
      barItem: BottomNavigationBarItem(
        activeIcon: Container(
          decoration: BoxDecoration(
            color: Color(0xff24d900),
            shape: BoxShape.circle,
          ),
          padding: EdgeInsets.all(2.0),
          height: 27,
          child: CircleAvatar(
            child: Image.asset('assets/raw/mock_profile_image.png'),
          ),
        ),
        icon: Container(
          height: 27,
          child: CircleAvatar(
            child: Image.asset('assets/raw/mock_profile_image.png'),
          ),
        ),
        title: SizedBox.shrink(),
      ),
    );
  }
}
