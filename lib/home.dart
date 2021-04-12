import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<HomePage> {
  String msg;

  final channelName = 'com.lsambo02.channel_demo/hello';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Center(
                child: Text(
              'Talk to the other side',
              style: TextStyle(
                  fontSize: 30,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w900),
            )),
            height: MediaQuery.of(context).size.height / 6,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(100))),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                    child: Text('Dizer Olá e ser Ignorado',
                        style: TextStyle(
                            fontSize: 15, fontStyle: FontStyle.italic)),
                    onPressed: () => callTheOtherSide()),
                ElevatedButton(
                    child: Text('Conversar',
                        style: TextStyle(
                            fontSize: 15, fontStyle: FontStyle.italic)),
                    onPressed: () => mutualConverasion()),
                msg != null
                    ? Container(
                        margin: EdgeInsets.only(right: 20),
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          child: Text(msg ?? '',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.blueGrey),
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ],
      )),
    );
  }

  callTheOtherSide() async {
    setState(() {
      msg = null;
    });
    final methodChannel = MethodChannel(channelName);
    await methodChannel.invokeMethod("hello");
  }

  Future mutualConverasion() async {
    String _msg;
    try {
      final methodChannel = MethodChannel(channelName);
      _msg = await methodChannel.invokeMethod("convo");
    } on PlatformException catch (err) {
      msg = "Não te posso responder $err";
    }
    setState(() {
      msg = _msg;
    });
  }
}
