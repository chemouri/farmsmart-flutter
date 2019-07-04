import 'package:farmsmart_flutter/farmsmart_localizations.dart';
import 'package:farmsmart_flutter/redux/home/screens.dart';
import 'package:farmsmart_flutter/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
import 'package:farmsmart_flutter/utils/styles.dart';

// We define here generic margins for the app
abstract class CustomAppBar {
  static AppBar build(BuildContext context, int currentHomeTab, Function goToPrivacyPolicy) {
    FarmsmartLocalizations localizations = FarmsmartLocalizations.of(context);
    switch (currentHomeTab) {
      case HomeScreen.MY_PLOT_TAB:
        return buildForHome(localizations.myPlotTab, profileAction(),
            popUpMenuAction(goToPrivacyPolicy), homeIcon());
        break;
      case HomeScreen.PROFIT_LOSS_TAB:
        return buildWithTitle(localizations.profitLossTab);
        break;
      case HomeScreen.ARTICLES_TAB:
        return buildForHome(localizations.discoverTab, profileAction(),
            popUpMenuAction(goToPrivacyPolicy), homeIcon());
        break;
      case HomeScreen.COMMUNITY_TAB:
        return buildWithTitle(localizations.communityTab);
        break;
    }
    return AppBar();
  }

  static AppBar buildWithTitle(String title) {
    return AppBar(
        centerTitle: true, title: Text(title, style: Styles.appBarTextStyle()));
  }

  static AppBar buildForHome(String title, Widget profileActions,
      Widget privacyAction, Widget homeIcon) {
    return AppBar(
      leading: homeIcon,
      automaticallyImplyLeading: true,
      // adds the back button automatically
      title: Text(title, style: Styles.appBarTextStyle()),
      actions: <Widget>[profileActions, privacyAction],
      centerTitle: true,
    );
  }

  static AppBar buildForDetail(String title) {
    return AppBar(
      leading: backIcon(),
      automaticallyImplyLeading: true, // adds the back button automatically
      title: Text(title, style: Styles.appBarDetailTextStyle()),
      centerTitle: true,
    );
  }

  static Widget profileAction() {
    return IconButton(
        icon: Icon(Icons.account_circle,
            color: Color(primaryGreen), size: appBarIconSize),
        onPressed: () {});
  }

  static Widget shareAction(Function action) {
    final Color appBarButtonsColor = const Color(0xFF1a1b46);

    return Container(
      margin: EdgeInsets.only(right: 22.0),
      child: IconButton(
        icon: Icon(Icons.share, color: appBarButtonsColor, size: 22.0),
        onPressed: action(),
      ),
    );
  }

  static Widget popUpMenuAction(Function goToPrivacyPolicy) {
    return IconButton(
        icon: PopupMenuButton(
          onSelected: goToPrivacyPolicy,
          itemBuilder: (BuildContext context) {
            return popUpMenu.map((String action) {
              return PopupMenuItem<String>(
                value: action,
                child: Text(action),
              );
            }).toList();
          },
        ),
        onPressed: () {});
  }

  static List<String> popUpMenu = <String>[Strings.appbarPopUpPolicies];

  static Widget homeIcon() {
    return Image.asset(Assets.APP_ICON);
  }

  static Widget backIcon() {
    final Color appBarButtonsColor = const Color(0xFF1a1b46);
    return Container(
      margin: EdgeInsets.only(left: 25),
      child: BackButton(
          color: appBarButtonsColor,
      ),
    );
  }
}
