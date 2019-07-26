import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/common/LoadableViewModel.dart';
import 'package:farmsmart_flutter/ui/common/RefreshableViewModel.dart';
import 'package:farmsmart_flutter/ui/common/recommendation_card/recommendation_card_view_model.dart';

typedef BoolforIndexFunction = bool Function(int index);

class RecommendationsListViewModel implements RefreshableViewModel, LoadableViewModel{
  static final error = RecommendationsListViewModel(loadingStatus: LoadingStatus.ERROR);
  final String title;
  final LoadingStatus loadingStatus;

  final List<RecommendationCardViewModel> items;
  final Function refresh;
  final Function apply; 
  final Function clear;
  final BoolforIndexFunction isHeroItem;
  final bool canApply;

  RecommendationsListViewModel({
    String title,
    LoadingStatus loadingStatus,
    List<RecommendationCardViewModel> items,
    Function refresh,
    Function apply,
    Function clear,
    BoolforIndexFunction isHeroItem, 
    bool canApply,

  })  : this.title = title,
        this.loadingStatus = loadingStatus,
        this.items = items,
        this.refresh = refresh,
        this.apply = apply,
        this.clear = clear,
        this.isHeroItem = isHeroItem,
        this.canApply = canApply;
}
