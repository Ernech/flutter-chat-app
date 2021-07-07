import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String ruta;
  final String textoPrincipal;
  final String textoRuta;
  const Labels(
      {Key key,
      @required this.ruta,
      @required this.textoPrincipal,
      @required this.textoRuta})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Text(this.textoPrincipal,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                  fontWeight: FontWeight.w300)),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, this.ruta);
            },
            child: Text(
              this.textoRuta,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
