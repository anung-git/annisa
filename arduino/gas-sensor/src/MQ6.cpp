#include "MQ6.h"

void MQ6::run()
{
}
MQ6::MQ6(/* args */)
{
    Mq.setRegressionMethod(1); //_PPM =  a*ratio^b
    Mq.setA(2127.2);
    Mq.setB(-2.526); // Configurate the ecuation values to get CH4 concentration
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
    Mq.init();
}

MQ6::~MQ6()
{
}
