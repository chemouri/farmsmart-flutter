import 'package:flutter/material.dart';

class RoundedButtonViewModel {
  String title;
  IconData icon;
  Function onTap;
  BuildContext context;

  RoundedButtonViewModel(this.context, {this.title, this.icon, this.onTap});
}

RoundedButtonViewModel buildButtonViewModel(BuildContext context, {String title, IconData icon, Function onTap}) {
  return RoundedButtonViewModel(context, title: title, icon : icon, onTap: () => onTap(context));
}

abstract class RoundedButtonStyle {

  final Color iconButtonColor;
  final Color backgroundColor;

  final BoxShape buttonShape;
  final BorderRadius borderShape;

  final EdgeInsets edgePadding;
  final TextStyle buttonTextStyle;

  final double size;
  final double iconEdgePadding;
  final double buttonIconSize;

  RoundedButtonStyle(this.size,
      this.iconButtonColor, this.backgroundColor, this.iconEdgePadding,
      {this.buttonShape, this.borderShape, this.edgePadding,
        this.buttonTextStyle, this.buttonIconSize});
}

class _DefaultStyle implements RoundedButtonStyle {

  final Color iconButtonColor =  const Color(0xFFFFFFFF);
  final Color backgroundColor =  const Color(0xff25df0c);

  final BoxShape buttonShape = BoxShape.rectangle;
  final BorderRadius borderShape = const BorderRadius.all(Radius.circular(20));

  final EdgeInsets edgePadding = const EdgeInsets.only(left: 32, top: 31, right: 32, bottom: 32);
  final TextStyle buttonTextStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xffffffff));

  final double iconEdgePadding = 5;
  final double size = 56.0;
  final double buttonIconSize = null;

  const _DefaultStyle();
}

class RoundedButton {
  static build(
      {RoundedButtonStyle style = const _DefaultStyle(),
        @required  BuildContext context,
        String title, IconData icon,
        Function onTap}) {
    return _buildRoundedButton(style, context , title: title, icon: icon, onTap: onTap);
  }

  static Widget _buildRoundedButton(RoundedButtonStyle buttonStyle, BuildContext context, {String title, IconData icon,
    Function onTap}) {

    RoundedButtonViewModel viewModel = buildButtonViewModel(context, title: title, icon: icon, onTap: onTap);

    List<Widget> _buildButtonContent(){
      List<Widget> listBuilder = [];
      if (viewModel.icon != null) {
        listBuilder.add(
            Icon(
              viewModel.icon,
              size: buttonStyle.buttonIconSize,
              color: buttonStyle.iconButtonColor,
            )
        );
      }
      if (viewModel.title != null) {
        listBuilder.add(
            Text(
                viewModel.title,
                style: buttonStyle.buttonTextStyle
            ));
      }
      return listBuilder;
    }

    return GestureDetector(
      onTap: () => _showToast(viewModel.context),
      child: Padding(
        padding: buttonStyle.edgePadding,
        child: Container(
          alignment: Alignment.center,
          height: buttonStyle.size,
          width: buttonStyle.size,
          decoration: BoxDecoration(
              color: buttonStyle.backgroundColor,
              shape: buttonStyle.buttonShape,
              borderRadius: buttonStyle.borderShape
          ),
          child: Wrap(
            direction: Axis.horizontal,
            children: _buildButtonContent(),
          ),
        ),
      ),
    );
  }

//FIXME: Only is built for show that this buttons are not functional yet
  static void _showToast(BuildContext context) {
    final String toastText = "Not Implemented Yet";
    final String toastButtonText = "BACK";
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
        SnackBar(
          content: Text(
              toastText
          ),
          action: SnackBarAction(label: toastButtonText, onPressed: scaffold.hideCurrentSnackBar),
        )
    );
  }
}