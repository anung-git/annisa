#if !defined(MQ6_H)
#define MQ6_H

#include <MQUnifiedsensor.h>



class MQ6
{
private:
    MQUnifiedsensor* Mq;// = new MQUnifiedsensor();
    /* data */
public:
    MQ6();
    void loop();
    ~MQ6();
    float readLPG();
};
#endif // MQ6_H