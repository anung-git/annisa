import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:percent_indicator/percent_indicator.dart';
// import 'package:ascii.dart';

import 'mqtt.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // @override
  // Widget build(BuildContext context) {
  // static final String path = "lib/src/pages/profile/profile9.dart";
  int ppm = 0;
  double suhu = 0.0;
  double humidity = 0.0;
  bool mode = false;
  bool fan = false;
  final test = Mqtt();
  @override
  void initState() {
    super.initState();
    mqttConnect();
  }

  @override
  void dispose() {
    test.disconnect();
    super.dispose();
  }

  void mqttConnect() async {
    await test.connect('broker.mqtt-dashboard.com');
    test.onDisconnected = onDisconnected;
    test.onConnected = onConnected;
    test.onSubscribed = onSubscribed;
    test.pongCallback = pong;
    test.subscribeCallback = msgCall;
    // const topic = 'annisa'; // Not a wildcard topic
    test.subscribe('annisa');
    test.subscribe('annisa/temp');
    test.subscribe('annisa/humi');
  }

  void msgCall(String topic, String msg) {
    setState(() {
      if (topic == 'annisa') {
        ppm = int.parse(msg);
      }
      if (topic == 'annisa/temp') {
        suhu = double.parse(msg);
      }
      if (topic == 'annisa/humi') {
        humidity = double.parse(msg);
      }
    });
  }

  void onSubscribed(String topic) {
    print('EXAMPLE::Subscription confirmed for topic $topic');
  }

  void onDisconnected() {
    print('EXAMPLE::OnDisconnected client callback - Client disconnection');
  }

  void onConnected() {}

  void pong() {
    print('EXAMPLE::Ping response client callback invoked');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: OvalBottomBorderClipper(),
          child: Container(
            margin: const EdgeInsets.only(top: 30),
            height: 500,
            decoration: BoxDecoration(
              color: Colors.greenAccent,
            ),
          ),
        ),
        ClipPath(
          clipper: OvalBottomBorderClipper(),
          child: Container(
            height: 420,
            decoration: BoxDecoration(
                // image: DecorationImage(
                // image: NetworkImage(pancake), fit: BoxFit.cover),
                // image: NetworkImage(
                //     'https://github.com/flutter/plugins/raw/master/packages/video_player/video_player/doc/demo_ipod.gif?raw=true'),
                // fit: BoxFit.cover),
                ),
            foregroundDecoration:
                BoxDecoration(color: Colors.green.withOpacity(0.8)),
          ),
        ),
        ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            const SizedBox(height: 90),
            CircularPercentIndicator(
              radius: 200.0,
              lineWidth: 13.0,
              animation: true,
              animateFromLastPercent: true,
              percent: (ppm / 100),
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$ppm%",
                    style: new TextStyle(
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.italic,
                        fontSize: 40.0,
                        color: Colors.white),
                  ),
                  Text(
                    "ppm",
                    style: new TextStyle(
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.italic,
                        fontSize: 20.0,
                        color: Colors.white),
                  )
                ],
              ),
              // footer: new Text(
              //   "Sales this week",
              //   style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
              // ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.pinkAccent,
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 10.0),
            Text(
              "Annisa",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5.0),
            Text(
              "Flutter & Full Stack Developer",
              style: TextStyle(
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10.0),
            Card(
              color: Colors.white,
              elevation: 0,
              margin: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 32.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Icon(
                            Icons.thermostat,
                            color: Colors.redAccent,
                            size: 37,
                          ),
                          Text(
                            suhu.toString() + '°C',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Text(
                            "suhu",
                            style: new TextStyle(
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.italic,
                                fontSize: 15.0,
                                color: Colors.black87),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Icon(
                            Icons.ac_unit,
                            color: Colors.blue,
                            size: 35.0,
                          ),
                          Text(
                            humidity.toString() + '%',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Text(
                            "humidity",
                            style: new TextStyle(
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.italic,
                                fontSize: 15.0,
                                color: Colors.black87),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            ListTile(
              title: Text(
                "Fan",
                // style: _itemHeader,
              ),
              leading: Icon(Icons.notifications),
            ),
            SwitchListTile(
              value: mode,
              title: Text("Fan Mode Auto"),
              onChanged: (value) {
                setState(() {
                  mode = value;
                });
              },
              secondary: SizedBox(
                width: 10,
              ),
            ),
            SwitchListTile(
              value: mode == false ? fan : false,
              title: Text("Fan on/off"),
              onChanged: (value) {
                setState(() {
                  fan = value;
                });
              },
              secondary: SizedBox(
                width: 10,
              ),
            ),
          ],
        )
      ],
    );
    // );
  }
}
