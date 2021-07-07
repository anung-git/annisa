#if !defined(MQ6_H)
#define MQ6_H

#include <MQUnifiedsensor.h>

//Definitions
#define placa "Arduino UNO"
#define Voltage_Resolution 5
#define pin A0                //Analog input 0 of your arduino
#define type "MQ-6"           //MQ6
#define ADC_Bit_Resolution 10 // For arduino UNO/MEGA/NANO
#define RatioMQ6CleanAir 10   //RS / R0 = 10 ppm
//#define calibration_button 13 //Pin to calibrate your sensor

//Declare Sensor
// (placa, Voltage_Resolution, ADC_Bit_Resolution, pin, type);

class MQ6
{
private:
    MQUnifiedsensor Mq;// = new MQUnifiedsensor();
    /* data */
public:
    MQ6();
    void run();
    ~MQ6();
};
#endif // MQ6_H