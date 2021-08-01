#include <Arduino.h>
#include <ESP8266WiFi.h>
#include "AndroidMqtt.h"
#include "MQ6.h"

// Update these with values suitable for your network.
// const char *ssid = "ardinista_plus";                   //nama wifi
// const char *password = "ardiasta";                     //password wifi
// const char *topic = "gas";                             //topic mqtt
// const char *mqtt_server = "broker.mqtt-dashboard.com"; // server mqtt

#define nama_wifi "ardinista_plus"                   // wifi
#define password_wifi "ardiasta"                     //password_wifi wifi
#define topic "gas"                                  //topic mqtt
#define mqtt_server "broker.mqtt-dashboard.com"      // server mqtt

MQ6 sensor = MQ6();
AndroidMqtt android = AndroidMqtt();

unsigned long lastMsg = 0;

void setup()
{
  pinMode(BUILTIN_LED, OUTPUT); // Initialize the BUILTIN_LED pin as an output
  Serial.begin(9600);
  WiFi.mode(WIFI_STA);
  WiFi.begin(nama_wifi, password_wifi);
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(500);
  }
  android.connect(mqtt_server, topic);
}

int val;
void loop()
{
  // sensor.run();
  android.loop();

  unsigned long now = millis();
  if (now - lastMsg > 3000)
  {
    val++;
    lastMsg = now;
    android.publish("gas", (val % 2) == 0 ? "1" : "0");
    Serial.print("Publish ke ");
    Serial.println(val);
    String buffer;
    buffer = String(random(100));

    android.publish("annisa",buffer);
    buffer = String(0.0314 *random(1000));
    android.publish("annisa/temp",buffer);
    buffer = String(random(20,80));
    android.publish("annisa/humi",buffer);
  }
}