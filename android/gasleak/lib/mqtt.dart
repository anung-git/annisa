import 'dart:io';
import 'dart:math';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

typedef MsgCallback = void Function(String topic, String msg);

class Mqtt {
  late MqttServerClient client;
  MsgCallback? _msgCallback;
  void publish(String topic, String msg) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(msg);
    client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
  }

  set onSubscribed(SubscribeCallback? cb) {
    client.onSubscribed = cb;
  }

  set subscribeCallback(MsgCallback? cb) {
    _msgCallback = cb;
  }

  set onDisconnected(DisconnectCallback? cb) {
    client.onDisconnected = cb;
  }

  set onConnected(ConnectCallback? cb) {
    client.onConnected = cb;
  }

  set pongCallback(PongCallback? cb) {
    client.pongCallback = cb;
  }

  Future<void> connect(String server) async {
    client = MqttServerClient(server, '');
    client.keepAlivePeriod = 20;
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      client.disconnect();
    }

    var rng = Random();
    int uid = rng.nextInt(10000);
    final connMess = MqttConnectMessage()
        .withClientIdentifier('Mqtt_MyClientUniqueId' + uid.toString())
        .withWillTopic(
            'willtopic') // If you set this you must set a will message
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    print('EXAMPLE::Mosquitto client connecting....');
    client.connectionMessage = connMess;

    try {
      await client.connect();
    } on NoConnectionException catch (e) {
      // Raised by the client when connection fails.
      print('EXAMPLE::client exception - $e');
      client.disconnect();
    } on SocketException catch (e) {
      // Raised by the socket layer
      print('EXAMPLE::socket exception - $e');
      client.disconnect();
    }

    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      final tp = c[0].topic;
      _msgCallback!(tp, pt);
    });
  }

  void disconnect() {
    client.disconnect();
    // dele client;
  }

  void subscribe(String topic) {
    print("connecting to " + topic);
    client.subscribe(topic, MqttQos.atMostOnce);
  }
}
