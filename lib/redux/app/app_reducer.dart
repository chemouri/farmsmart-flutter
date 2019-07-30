import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/redux/home/home_reducer.dart';

AppState appReducer(AppState state, dynamic action) =>
    AppState(
        homeState: homeReducer(state.homeState ,action),
    );