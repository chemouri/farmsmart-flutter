import 'package:farmsmart_flutter/ui/profitloss/RecordAmount.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class _Constants {
  static final currentDate = DateTime.now();
  static final minDateLimit = DateTime(2019, 6);
  static final maxDateLimit = DateTime(2101);
  static final dateFormatter = DateFormat('dd MMMM yyyy');
  static final dateIcon = "assets/icons/detail_icon_date.png";
  static final cropIcon = "assets/icons/detail_icon_best_soil.png";
  static final descriptionIcon = "assets/icons/detail_icon_description.png";
  static final arrowIcon = "assets/icons/chevron.png";
}

class _Strings {
  static final DATE = Intl.message("Date");
  static final CROP = Intl.message("Crop");
  static final TODAY = Intl.message("Today");
  static final SELECT = Intl.message("Select...");
  static final DESCRIPTION = Intl.message("Description (optional)...");
  static final EMPTY_STRING = Intl.message("");
}

enum RecordCellType {
  pickDate,
  pickItem,
  description,
}

class RecordAmountListItemViewModel {
  RecordCellType type;
  DateTime selectedDate;
  List<String> listOfCrops = [];
  String selectedItem;
  String description;
  bool isEditable;

  RecordAmountListItemViewModel({
    this.type,
    this.selectedDate,
    this.listOfCrops,
    this.selectedItem,
    this.description,
    this.isEditable: true,
  });
}

class RecordAmountListItemStyle {
  final TextStyle titleTextStyle;
  final TextStyle pendingDetailTextStyle;
  final TextStyle detailTextStyle;

  final EdgeInsets actionItemEdgePadding;
  final EdgeInsets cardMargins;

  final double iconHeight;
  final double iconLineSpace;
  final double detailTextSpacing;

  final int maxLines;

  const RecordAmountListItemStyle({
    this.titleTextStyle,
    this.pendingDetailTextStyle,
    this.detailTextStyle,
    this.actionItemEdgePadding,
    this.cardMargins,
    this.iconHeight,
    this.iconLineSpace,
    this.detailTextSpacing,
    this.maxLines,
  });

  RecordAmountListItemStyle copyWith({
    TextStyle titleTextStyle,
    TextStyle pendingDetailTextStyle,
    TextStyle detailTextStyle,
    EdgeInsets actionItemEdgePadding,
    EdgeInsets cardMargins,
    double iconHeight,
    double iconLineSpace,
    double detailTextSpacing,
    int maxLines,
  }) {
    return RecordAmountListItemStyle(
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      pendingDetailTextStyle:
          pendingDetailTextStyle ?? this.pendingDetailTextStyle,
      detailTextStyle: detailTextStyle ?? this.detailTextStyle,
      actionItemEdgePadding:
          actionItemEdgePadding ?? this.actionItemEdgePadding,
      cardMargins: cardMargins ?? this.cardMargins,
      iconHeight: iconHeight ?? this.iconHeight,
      iconLineSpace: iconLineSpace ?? this.iconLineSpace,
      detailTextSpacing: detailTextSpacing ?? this.detailTextSpacing,
      maxLines: maxLines ?? this.maxLines,
    );
  }
}

class _DefaultStyle extends RecordAmountListItemStyle {
  final TextStyle titleTextStyle = const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: Color(0xFF1a1b46),
  );

  final TextStyle detailTextStyle = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: Color(0xff767690),
  );

  final TextStyle pendingDetailTextStyle = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: Color(0x4c767690),
  );

  final EdgeInsets actionItemEdgePadding =
      const EdgeInsets.only(left: 32, right: 32, top: 15, bottom: 15);
  final EdgeInsets cardMargins = const EdgeInsets.all(0);

  final double iconHeight = 20;
  final double iconLineSpace = 22;
  final double detailTextSpacing = 13;

  final int maxLines = 5;

  const _DefaultStyle(
      {TextStyle titleTextStyle,
      TextStyle pendingDetailTextStyle,
      TextStyle detailTextStyle,
      EdgeInsets actionItemEdgePadding,
      EdgeInsets cardMargins,
      double iconHeight,
      double iconLineSpace,
      double detailTextSpacing,
      int maxLines});
}

const RecordAmountListItemStyle _defaultStyle = const _DefaultStyle();

class RecordAmountListItem extends StatefulWidget {
  final RecordAmountListItemStyle _style;
  final RecordAmountListItemViewModel _viewModel;
  final GlobalKey _pickerKey = new GlobalKey();

  RecordAmountState parent;

  RecordAmountListItem(
      {Key key,
      RecordAmountListItemViewModel viewModel,
      RecordAmountListItemStyle style = _defaultStyle,
      RecordAmountState parent})
      : this._viewModel = viewModel,
        this._style = style,
        this.parent = parent,
        super(key: key);

  @override
  _RecordAmountListItemState createState() => _RecordAmountListItemState();
}

class _RecordAmountListItemState extends State<RecordAmountListItem> {
  final _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      //widget._viewModel.selectedDate = DateTime.now();
    });
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    RecordAmountListItemViewModel viewModel = widget._viewModel;
    RecordAmountListItemStyle style = widget._style;

    return Column(
      children: _buildItemContent(viewModel, style),
    );
  }

  List<Widget> _buildItemContent(RecordAmountListItemViewModel viewModel,
      RecordAmountListItemStyle style) {
    List<Widget> listBuilder = [];

    switch (viewModel.type) {
      case RecordCellType.pickDate:
        listBuilder.add(_buildPickDate(viewModel, style));
        break;
      case RecordCellType.pickItem:
        listBuilder.add(_buildPickItem(viewModel, style));
        break;
      case RecordCellType.description:
        listBuilder.add(_buildDescription(viewModel, style));
        break;
    }
    return listBuilder;
  }

  ListTile _buildPickDate(RecordAmountListItemViewModel viewModel,
      RecordAmountListItemStyle style) {
    return ListTile(
      leading: Image.asset(
        _Constants.dateIcon,
        height: style.iconHeight,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            _Strings.DATE,
            textAlign: TextAlign.start,
            style: style.titleTextStyle,
          ),
          Text(
            _formatDate(viewModel.selectedDate) ==
                    _formatDate(_Constants.currentDate)
                ? _Strings.TODAY
                : _formatDate(viewModel.selectedDate),
            textAlign: TextAlign.end,
            style: style.detailTextStyle,
          )
        ],
      ),
      trailing: viewModel.isEditable
          ? Image.asset(
              _Constants.arrowIcon,
              height: style.detailTextSpacing,
            )
          : null,
      dense: true,
      contentPadding: style.actionItemEdgePadding,
      onTap: () => _selectDate(context, viewModel),
      enabled: viewModel.isEditable,
    );
  }

  ListTile _buildPickItem(RecordAmountListItemViewModel viewModel,
      RecordAmountListItemStyle style) {
    return ListTile(
      leading: Image.asset(
        _Constants.cropIcon,
        height: style.iconHeight,
      ),
      title: viewModel.isEditable
          ? PopupMenuButton(
              key: widget._pickerKey,
              onSelected: (selectedItem) => _changeDropDownItem(selectedItem),
              itemBuilder: (BuildContext context) =>
                  _getDropDownMenuItems(viewModel),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    _Strings.CROP,
                    textAlign: TextAlign.start,
                    style: style.titleTextStyle,
                  ),
                  viewModel.selectedItem == null
                      ? Text(
                          _Strings.SELECT,
                          textAlign: TextAlign.end,
                          style: style.pendingDetailTextStyle,
                        )
                      : Text(
                          viewModel.selectedItem,
                          textAlign: TextAlign.end,
                          style: style.detailTextStyle,
                        )
                ],
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  _Strings.CROP,
                  textAlign: TextAlign.start,
                  style: style.titleTextStyle,
                ),
                Text(
                  viewModel.selectedItem == null
                      ? _Strings.SELECT
                      : viewModel.selectedItem,
                  textAlign: TextAlign.end,
                  style: style.detailTextStyle,
                )
              ],
            ),
      trailing: viewModel.isEditable
          ? Image.asset(
              _Constants.arrowIcon,
              height: style.detailTextSpacing,
            )
          : null,
      dense: true,
      contentPadding: style.actionItemEdgePadding,
      onTap: () => showPopUpMenu(),
      enabled: viewModel.isEditable,
    );
  }

  ListTile _buildDescription(RecordAmountListItemViewModel viewModel,
      RecordAmountListItemStyle style) {
    return ListTile(
      title: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              _Constants.descriptionIcon,
              height: style.iconHeight,
            ),
            SizedBox(width: 20),
            Expanded(
              child: viewModel.isEditable
                  ? TextField(
                      decoration: InputDecoration(
                          hintText: _Strings.DESCRIPTION,
                          hintStyle: style.pendingDetailTextStyle,
                          border: InputBorder.none,
                          contentPadding: style.cardMargins,
                          counterText: _Strings.EMPTY_STRING),
                      textAlign: TextAlign.left,
                      style: style.detailTextStyle,
                      maxLines: style.maxLines,
                      controller: _textFieldController,
                      onEditingComplete: () => _checkTextField(viewModel),
                      onChanged: (description) => _saveDescription(description),
                      textInputAction: TextInputAction.next,
                      enabled: viewModel.isEditable,
                    )
                  : Text(viewModel.description, style: style.titleTextStyle),
            ),
          ],
        ),
      ),
      dense: true,
      contentPadding: style.actionItemEdgePadding,
      onTap: () => _selectDate(context, viewModel),
      enabled: viewModel.isEditable,
    );
  }

  _saveDescription(String description) {
    setState(() {
      if (description != "") {
        widget.parent.description = description;
      }
    });
  }

  void showPopUpMenu() {
    dynamic popUpMenustate = widget._pickerKey.currentState;
    popUpMenustate.showButtonMenu();
  }

  Future<Null> _selectDate(
    BuildContext context,
    RecordAmountListItemViewModel viewModel,
  ) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: viewModel.selectedDate,
      firstDate: _Constants.minDateLimit,
      lastDate: _Constants.maxDateLimit,
    );

    if (picked != null) {
      setState(() {
        viewModel.selectedDate = picked;
        widget.parent.selectedDate = picked;
      });
    }
  }

  String _formatDate(DateTime selectedDate) {
    String formatted = _Constants.dateFormatter.format(selectedDate);
    return formatted;
  }

  List<PopupMenuItem> _getDropDownMenuItems(
      RecordAmountListItemViewModel viewModel) {
    List<PopupMenuItem> items = [];
    for (String crop in viewModel.listOfCrops) {
      items.add(PopupMenuItem(value: crop, child: Text(crop)));
    }
    return items;
  }

  void _checkTextField(RecordAmountListItemViewModel viewModel) {
    setState(() {
      if (_textFieldController.text != null) {
        viewModel.description = _textFieldController.text;
        widget.parent.description = _textFieldController.text;
      }
    });
  }

  void _changeDropDownItem(String selectedCrop) {
    setState(() {
      widget._viewModel.selectedItem = selectedCrop;
      widget.parent.selectedCrop = selectedCrop;
      widget.parent.cropIsFilled = true;
      widget.parent.checkIfFilled();
    });
  }
}
