#include "AndroidMqtt.h"
void AndroidMqtt::reconnect()
{
    // Loop until we're reconnected
    while (!client->connected())
    {
        // Create a random client ID
        String clientId = "ESP8266Client-";
        clientId += String(random(0xffff), HEX);
        if (client->connect(clientId.c_str()))
        {
            client->subscribe(this->topic);
        }
        else
        {
            // Wait 5 seconds before retrying
            delay(5000);
        }
    }
}

void AndroidMqtt::loop()
{
    if (!client->connected())
    {
        reconnect();
    }
    client->loop();
}

void AndroidMqtt::callback(char *topic, byte *payload, unsigned int length)
{
    Serial.print("Message arrived [");
    Serial.print(topic);
    Serial.print("] ");
    for (unsigned int i = 0; i < length; i++)
    {
        Serial.print((char)payload[i]);
    }
    Serial.println();

    if ((char)payload[0] == '1')
    {
        digitalWrite(BUILTIN_LED, LOW);
    }
    else
    {
        digitalWrite(BUILTIN_LED, HIGH);
    }
}

void AndroidMqtt::publish(const char *topic, const char *msg)
{
    Serial.print("android Publish ");
    Serial.println(msg);
    client->publish(topic, msg);
}
void AndroidMqtt::connect(const char *server, const char *topic)
{
    this->topic = topic;
    client->setServer(server, 1883);
    client->setCallback(this->callback);
}
AndroidMqtt::AndroidMqtt()
{
    espClient = new WiFiClient();
    client = new PubSubClient(*espClient);
}

AndroidMqtt::~AndroidMqtt()
{
}
