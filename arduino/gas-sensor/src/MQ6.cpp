#include "MQ6.h"

void MQ6::loop()
{
}
MQ6::MQ6(/* args */)
{
//Definitions
#define placa "NodeMCU ESP8266"
#define Voltage_Resolution 5
#define pin A0                //Analog input 0 of your arduino
#define type "MQ-6"           //MQ6
#define ADC_Bit_Resolution 10 // For arduino UNO/MEGA/NANO
#define RatioMQ6CleanAir 10   //RS / R0 = 10 ppm
    //#define calibration_button 13 //Pin to calibrate your sensor

    //Declare Sensor
    Mq = new MQUnifiedsensor(placa, Voltage_Resolution, ADC_Bit_Resolution, pin, type);
    Mq->setRegressionMethod(1); //_PPM =  a*ratio^b
    Mq->setA(2127.2);
    Mq->setB(-2.526); // Configurate the ecuation values to get CH4 concentration
    /*
    Exponential regression:
    GAS     | a      | b
    H2      | 88158  | -3.597
    LPG     | 1009.2 | -2.35
    CH4     | 2127.2 | -2.526
    CO      | 1000000000000000 | -13.5
    Alcohol | 50000000 | -6.017
    */

    /*****************************  MQ Init ********************************************/
    //Remarks: Configure the pin of arduino as input.
    /************************************************************************************/
    Mq->init();
}

MQ6::~MQ6()
{
}
