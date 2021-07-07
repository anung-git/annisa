#if !defined(AndroidMqtt_H)
#define AndroidMqtt_H

#include <Arduino.h>

class AndroidMqtt
{
private:
    /* data */
public:
    AndroidMqtt(/* args */);

    void sendMessage(String msg);
    void sendGasValue(float data);
    void fanOn();
    void fanOff();

    ~AndroidMqtt();
};

#endif // AndroidMqtt_H