import 'dart:io';

import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final TextEditingController _textEditingController =
      new TextEditingController();
  final FocusNode _focusNode = new FocusNode();
  bool _estaEscribiendo = false;
  List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Column(
          children: <Widget>[
            CircleAvatar(
              maxRadius: 13,
              backgroundColor: Colors.blue[100],
              child: Text(
                'Te',
                style: TextStyle(fontSize: 12),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              'Melissa',
              style: TextStyle(fontSize: 12, color: Colors.black87),
            )
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
                child: ListView.builder(
                    reverse: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: _messages.length,
                    itemBuilder: (_, i) => _messages[i])),
            Divider(
              height: 1,
            ),
            //TODO: Caja de texto
            Container(
              color: Colors.white,
              height: 50,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
              child: TextField(
            decoration:
                InputDecoration.collapsed(hintText: 'Enviar Mensaje...'),
            controller: _textEditingController,
            onSubmitted: (_) {},
            onChanged: (String texto) {
              setState(() {
                if (texto.length > 0) {
                  _estaEscribiendo = true;
                } else {
                  _estaEscribiendo = false;
                }
              });
            },
            focusNode: _focusNode,
          )),
          //Botón de enviar
          Container(
            child: Platform.isIOS
                ? CupertinoButton(
                    child: Text('Enviar'),
                    onPressed: _estaEscribiendo
                        ? () =>
                            _handleSubmit(_textEditingController.text.trim())
                        : null)
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconTheme(
                      data: IconThemeData(color: Colors.blue),
                      child: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          icon: Icon(
                            Icons.send,
                          ),
                          onPressed: _estaEscribiendo
                              ? () => _handleSubmit(
                                  _textEditingController.text.trim())
                              : null),
                    ),
                  ),
            margin: EdgeInsets.symmetric(horizontal: 4.0),
          )
        ],
      ),
    ));
  }

  _handleSubmit(String texto) {
    if (texto.length < 1) {
      return;
    }
    print(texto);
    _textEditingController.clear();
    _focusNode.requestFocus();
    final newMessage = new ChatMessage(
      texto: texto,
      uid: '123',
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 400)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _estaEscribiendo = false;
    });
  }

  @override
  void dispose() {
    //TODO: off del socket

    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
