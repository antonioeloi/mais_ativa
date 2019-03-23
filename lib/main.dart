import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_chess_board/src/chess_board.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '+ativa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '+ativa'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _mode = 0;

  void _toChess() {
    setState(() {
      _mode = 1;
    });

    print(_mode);
  }

  void _toChat() {
    setState(() {
      _mode = 2;
    });

    print(_mode);
  }

  @override
  Widget build(BuildContext context) {
    if (_mode == 2) {
      return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Image(image: AssetImage("assets/mais_ativa_logo.png")),
            centerTitle: true,
          ),
          body: Center(
            child: Text("Conversa não implementada!"),
          ),
        ),
      );
    } else if (_mode == 1) {
      return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Image(image: AssetImage("assets/mais_ativa_logo.png")),
            centerTitle: true,
          ),
          body: Center(
            child: ChessBoard(
              size: 400.0,
              onMove: (move) {
                print(move);
              },
              onCheckMate: (color) {
                print(color);
              },
              onDraw: () {
                print("DRAW!");
              },
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Image(image: AssetImage("assets/mais_ativa_logo.png")),
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            ModeButton(
              _toChess,
              "Jogo",
              Colors.white,
              Color(0xFFAEEA00),
              Icon(
                Icons.videogame_asset,
                color: Colors.white,
                size: 40.0,
              ),
            ),
            ModeButton(
              _toChat,
              "Conversa",
              Colors.white,
              Color(0xFF0080EE),
              Icon(
                Icons.chat,
                color: Colors.white,
                size: 40.0,
              ),
            ),
            ModeButton(
              null,
              "Sugestões",
              Colors.black,
              Colors.white,
              Icon(
                Icons.lightbulb_outline,
                color: Colors.black,
                size: 40.0,
              ),
            ),
            SuggestionButton(
              _toChess,
              "Jogue Xadrez",
              "O seu neto quer que jogue xadrez!",
              Colors.black,
              Colors.white,
              Icon(
                Icons.videogame_asset,
                color: Colors.black,
                size: 40.0,
              ),
            ),
            SuggestionButton(
              null,
              "Faça um Ramo de Flores",
              "A pedido do centro de dia!",
              Colors.black,
              Colors.white,
              Icon(
                Icons.local_florist,
                color: Colors.black,
                size: 40.0,
              ),
            ),
            SuggestionButton(
              null,
              "Alongue o seu corpo!",
              "Não se esqueça de alongar o corpo, a pedido do seu médico!",
              Colors.black,
              Colors.white,
              Icon(
                Icons.person,
                color: Colors.black,
                size: 40.0,
              ),
            ),
            SuggestionButton(
              _toChess,
              "Jogue Xadrez",
              "Bata o recorde pessoal da sua amiga Gertrudes!",
              Colors.black,
              Colors.white,
              Icon(
                Icons.videogame_asset,
                color: Colors.black,
                size: 40.0,
              ),
            ),
          ],
        ),
      );
    }
  }

  Future<bool> _requestPop() {
    setState(() {
      _mode = 0;
    });
    return Future.value(false);
  }
}

class ModeButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  final Color textColor;
  final Color backgroundColor;
  final Icon icon;

  const ModeButton(this.onPressed, this.text, this.textColor,
      this.backgroundColor, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      height: 128.0,
      child: Material(
        color: this.backgroundColor,
        elevation: 4.0,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        child: InkWell(
          onTap: this.onPressed,
          child: Center(
            child: ListTile(
              leading: this.icon,
              title: Text(
                this.text,
                style: TextStyle(
                  color: this.textColor,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SuggestionButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Icon icon;

  const SuggestionButton(this.onPressed, this.title, this.text, this.textColor,
      this.backgroundColor, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Material(
        color: this.backgroundColor,
        elevation: 4.0,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        child: InkWell(
            onTap: this.onPressed,
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: this.icon,
                      title: Text(
                        this.title,
                        style: TextStyle(
                          color: this.textColor,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      this.text,
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
