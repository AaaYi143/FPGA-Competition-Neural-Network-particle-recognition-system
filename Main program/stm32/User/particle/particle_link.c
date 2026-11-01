#include "particle_link.h"
#include "stm32f1xx_hal.h"
#define RX_SIZE 2048u
_Static_assert(RX_SIZE > 1u && (RX_SIZE & (RX_SIZE-1u)) == 0u && RX_SIZE <= 32768u, "RX ring must fit 16-bit indices and have power-of-two capacity");
/* 2047 usable bytes: about 178 ms at continuously full 115200 8N1. */
static uint8_t rx[RX_SIZE];
static volatile uint16_t rx_head, rx_tail;
static volatile uint32_t rx_errors;
static ParticleParser parser;
void ParticleLink_Init(void)
{
    GPIO_InitTypeDef gpio={0};
    __HAL_RCC_GPIOA_CLK_ENABLE();
    __HAL_RCC_USART2_CLK_ENABLE();
    /* USART2 default RX is PA3. SIM800A must be disconnected from PA3.
       This RX-only endpoint does not reconfigure the debug USART1 MSP. */
    gpio.Pin=GPIO_PIN_3; gpio.Mode=GPIO_MODE_INPUT; gpio.Pull=GPIO_PULLUP;
    HAL_GPIO_Init(GPIOA,&gpio);
    USART2->CR1=0; USART2->CR2=0; USART2->CR3=0;
    USART2->BRR=(HAL_RCC_GetPCLK1Freq()+57600u)/115200u;
    (void)USART2->SR; (void)USART2->DR;
    rx_head=0; rx_tail=0; rx_errors=0; ParticleParser_Init(&parser);
    USART2->CR1=USART_CR1_UE|USART_CR1_RE|USART_CR1_RXNEIE;
    HAL_NVIC_SetPriority(USART2_IRQn,2,0);
    HAL_NVIC_EnableIRQ(USART2_IRQn);
}
void USART2_IRQHandler(void)
{
    uint32_t status=USART2->SR;
    if(status&(USART_SR_RXNE|USART_SR_ORE|USART_SR_FE|USART_SR_NE|USART_SR_PE)) {
        uint8_t value=(uint8_t)USART2->DR; /* SR then DR clears receive errors. */
        if(status&(USART_SR_ORE|USART_SR_FE|USART_SR_NE|USART_SR_PE)) rx_errors++;
        else {
            uint16_t next=(uint16_t)((rx_head+1u)&(RX_SIZE-1u));
            if(next==rx_tail) rx_errors++;
            else { rx[rx_head]=value; __DMB(); rx_head=next; }
        }
    }
}
int ParticleLink_Poll(ParticleMessage *message)
{
    while(rx_tail!=rx_head) {
        uint8_t value=rx[rx_tail];
        __DMB(); rx_tail=(uint16_t)((rx_tail+1u)&(RX_SIZE-1u));
        if(ParticleParser_Feed(&parser,value,message)) return 1;
    }
    return 0;
}
uint32_t ParticleLink_Errors(void) { return rx_errors+parser.rejected; }
