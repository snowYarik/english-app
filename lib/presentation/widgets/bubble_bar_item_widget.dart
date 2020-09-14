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
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      decoration: BoxDecoration(
          color: _hasFocus ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(15.0)),
      child: Icon(
        _iconData,
        color: _hasFocus ? Colors.white : Colors.grey,
      ),
    );
  }
}
