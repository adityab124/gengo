import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';


class Details extends StatefulWidget {
  final String text;
  Details(this.text);
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  final FlutterTts flutterTts = FlutterTts();
  @override
  Widget build(BuildContext context) {
    void _restartApp() async {
      Phoenix.rebirth(context);
    }
    speak() async {
      await flutterTts.speak(widget.text);
    }
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Scanned Text'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings_backup_restore_rounded),
            onPressed: () => _restartApp(),
          ),
          // IconButton(
          //   icon: Icon(Icons.translate_rounded),
          //   onPressed: () => _restartApp(),
          // ),
          IconButton(
            icon: Icon(Icons.speaker_phone_rounded),
            onPressed: () => speak(),
          ),

          IconButton(
            icon: Icon(Icons.copy),
            onPressed: () {
              FlutterClipboard.copy(widget.text).then((value) => _key
                  .currentState
                  .showSnackBar(new SnackBar(content: Text('Copied'))));
            },
          )
        ],
      ),
      body:
      DefaultTextStyle(
        child: Container(
            color: Colors.black,
            padding: EdgeInsets.all(4),
            alignment: Alignment.center,
            height: double.infinity,
            width: double.infinity,
            child: SelectableText(
                widget.text.isEmpty ? 'No Text Available' : widget.text),
          ),

        style: TextStyle(color: Colors.white, fontSize: 15),

      ),

    );
  }
}
