import 'package:flutter/material.dart';

class BubbleBarItemWidget extends StatelessWidget {
  const BubbleBarItemWidget({
    Key key,
    @required IconData iconData,
    @required bool hasFocus,
  })  : _iconData = iconData,
        _hasFocus = hasFocus,
        super(key: key);

  final IconData _iconData;
  final bool _hasFocus;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _hasFocus ? Colors.blue : Colors.transparent),
      child: Icon(
        _iconData,
        color: _hasFocus ? Colors.white : Colors.grey,
      ),
    );
  }
}
