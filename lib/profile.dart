import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hr/platform_channel.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController _textController;
  String _textRecieved;
  PlatformChannel _platformChannel;
  int _time;
  StreamSubscription _timerSubscription;

  @override
  void initState() {
    _textController = TextEditingController(text: '');
    _platformChannel = PlatformChannel();
    _time = 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildMethodChannel(context),
            Divider(
              height: 32,
              thickness: 2,
              color: Colors.grey[700],
            ),
            _buildEventChannel(context),
          ],
        ),
      ),
    );
  }

  Column _buildMethodChannel(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'MethodChannel',
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'Text for send',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: TextFormField(
            controller: _textController,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          'Text received',
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          '$_textRecieved',
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(
          height: 8,
        ),
        RaisedButton(
            onPressed: () async {
              _textRecieved = await _platformChannel.getStringReturnFromPlatform(_textController.text);
              setState(() {});
            },
            child: Text("Send Text")),
      ],
    );
  }

  Column _buildEventChannel(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'EventChannel',
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(
          height: 8,
        ),
        Text("Timer"),
        Text(
          "$_time",
          style: Theme.of(context).textTheme.headline5,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          RaisedButton(
              onPressed: () async {
                _timerSubscription = _platformChannel.getTimerStream.listen((int time) {
                  setState(() {
                    _time = time;
                  });
                });
              },
              child: Text("Start")),
          SizedBox(width: 16),
          RaisedButton(
              onPressed: () async {
                _timerSubscription.cancel();
              },
              child: Text("Stop")),
        ])
      ],
    );
  }
}
