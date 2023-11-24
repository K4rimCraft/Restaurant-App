#define F_CPU 8000000UL

#include <avr/io.h>
#include <util/delay.h>

int main()
{
    DDRA = 0xFF;
    PORTA = 0X55;
    while (1)
    {
        PORTA = ~PORTA;
        _delay_ms(500);
    }
    return 0;
}