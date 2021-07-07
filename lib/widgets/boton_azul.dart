import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final String text;
  final Function onPressd;

  const BotonAzul({Key key, @required this.text, @required this.onPressd})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        elevation: 2,
        highlightElevation: 5,
        shape: StadiumBorder(),
        color: Colors.blue,
        onPressed: this.onPressd,
        child: Container(
            width: double.infinity,
            height: 55,
            child: Center(
                child: Text(
              this.text,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ))));
  }
}
