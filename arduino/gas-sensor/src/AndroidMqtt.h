#if !defined(AndroidMqtt_H)
#define AndroidMqtt_H

#include <Arduino.h>
#include <PubSubClient.h>
#include <ESP8266WiFi.h>
class AndroidMqtt
{
private:
    /* data */
    WiFiClient *espClient;
    PubSubClient *client;
    const char *topic;
    static void callback(char *topic, byte *payload, unsigned int length);

public:
    AndroidMqtt();
    void loop();
    void reconnect();
    void publish(const char *topic, const char *msg);
    void connect(const char *server, const char *topic);

    //not implement
    void sendMessage(String msg);
    void sendGasValue(float data);
    void fanOn();
    void fanOff();
    ~AndroidMqtt();
};

#endif // AndroidMqtt_H