import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:social_sharing/social_sharing.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30),
            RaisedButton(
              child: Text('Share with twitter'),
              onPressed: () async {
                var response = await SocialSharing().twitter(
                    image: 'https://rotella.shell.com/en_us/coupons-rebates-and-sweepstakes/_jcr_content/pagePromo/image.img.960.jpeg/1526321293959/real-destinations-oo-ruben-with-mechanic-engine.jpeg',
                    url: 'https://rebatesme.com',
                    msg: 'twitter');
                if (response == 'success') {
                  print('navigate success');
                }
              },
            ),
            RaisedButton(
              child: Text('Share with facebook'),
              onPressed: () {
                SocialSharing().facebook(
                    url: 'https://rebatesme.com', msg: "some facebook message");
              },
            ),
            RaisedButton(
              child: Text('Share with system'),
              onPressed: () async {
                var response = await SocialSharing().system(msg: '');
                if (response == 'success') {
                  print('navigate success');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
