import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  @override
  final Widget _child;
  final String value;
  const Badge(this._child, this.value);
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      child: Stack(
        alignment: Alignment.center,
        children: [
          _child,
          value != '0'
              ? Positioned(
                  top: 8,
                  right: 2,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    child: FittedBox(
                      child: Text(
                        value,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.amber,
                    ),
                    constraints: BoxConstraints(
                        minWidth: 13,
                        maxWidth: 16,
                        maxHeight: 19,
                        minHeight: 13),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
