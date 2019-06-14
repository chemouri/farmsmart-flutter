import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/ui/common/network_image_from_future.dart';
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:farmsmart_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/utils/assets.dart';

class DiscoveryListItem {
  Widget buildListItem(ArticleEntity articleData, Function getRelatedArticles) {
    return GestureDetector(
        onTap: () {
          getRelatedArticles(articleData);
        },
        child: Padding(
          key: ValueKey(articleData.title ?? Strings.noTitleString),
          padding: Paddings.listOfArticlesPadding(),
          child: Container(
              height: 101,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      _buildListItemImage(articleData),
                      Padding(
                        padding: Paddings.leftPaddingSmall(),
                      ),
                      _buildArticleTitle(articleData),
                      _buildListIcon(),
                      Padding(
                        padding: Paddings.rightPaddingSmall(),
                      ),
                    ],
                  ),
                  Padding(
                    padding: Paddings.bottomPaddingSmall(),
                  ),
                  Dividers.listDividerLine()
                ],
              )),
        ));
  }

  _buildListItemImage(ArticleEntity articleData) {
    return NetworkImageFromFuture(
      articleData.imageUrl,
        height: listImageHeight,
        width: listImageWidth,
        fit: BoxFit.cover
    );
  }

  _buildArticleTitle(ArticleEntity articleData) {
    return Expanded(
      flex: listViewFlex,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(articleData.title ?? Strings.noTitleString,
              maxLines: titleMaxLines,
              overflow: TextOverflow.ellipsis,
              style: Styles.articleListTitleStyle()),
          Margins.generalListSmallerMargin(),
          Text(articleData.summary ?? Strings.myPlotItemDefaultTitle,
              maxLines: summaryMaxLines,
              overflow: TextOverflow.ellipsis,
              style: Styles.footerTextStyle()),
        ],
      ),
    );
  }

  _buildListIcon() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Icon(
            Icons.arrow_forward_ios,
            size: arrowIconSize,
            color: Color(primaryGrey),
          ),
        ],
      ),
    );
  }
}
