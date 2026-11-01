/* FPGA material-name display, STM32F103RC MINI, existing ILI9341 screen. */
#include "main.h"
#include "./usart/bsp_debug_usart.h"
#include "./led/bsp_led.h"
#include "./lcd/bsp_ili9341_lcd.h"
#include "./flash/bsp_spi_flash.h"
#include "./particle/particle_link.h"
#include "./particle/particle_ui.h"
#include <stdio.h>
extern uint16_t lcdid;
int main(void)
{
    ParticleMessage message;
    HAL_Init();
    SystemClock_Config();
    DEBUG_USART_Config();
    LED_GPIO_Config();
    ILI9341_Init();
    ILI9341_GramScan((lcdid==LCDID_ILI9341)?6:0);
    ILI9341_BackLed_Control(ENABLE);
    SPI_FLASH_Init();
    ParticleUI_Init();
    ParticleLink_Init();
    printf("\r\nFPGA particle display: PA3, 115200 8N1; protocol v1/v2; RESULT 0 empty, 1 millet, 2 pearl, 3 salt, 4 sugar; latest 20 votes\r\n");
    while(1) {
        while(ParticleLink_Poll(&message)) ParticleUI_OnMessage(&message);
        ParticleUI_Poll();
        HAL_Delay(2);
    }
}

void SystemClock_Config(void)
{
    RCC_ClkInitTypeDef clkinitstruct = {0};
    RCC_OscInitTypeDef oscinitstruct = {0};

    oscinitstruct.OscillatorType  = RCC_OSCILLATORTYPE_HSE;
    oscinitstruct.HSEState        = RCC_HSE_ON;
    oscinitstruct.HSEPredivValue  = RCC_HSE_PREDIV_DIV1;
    oscinitstruct.PLL.PLLState    = RCC_PLL_ON;
    oscinitstruct.PLL.PLLSource   = RCC_PLLSOURCE_HSE;
    oscinitstruct.PLL.PLLMUL      = RCC_PLL_MUL9;
    if (HAL_RCC_OscConfig(&oscinitstruct) != HAL_OK) {
        while (1);
    }

    clkinitstruct.ClockType      = (RCC_CLOCKTYPE_SYSCLK | RCC_CLOCKTYPE_HCLK |
                                    RCC_CLOCKTYPE_PCLK1 | RCC_CLOCKTYPE_PCLK2);
    clkinitstruct.SYSCLKSource   = RCC_SYSCLKSOURCE_PLLCLK;
    clkinitstruct.AHBCLKDivider  = RCC_SYSCLK_DIV1;
    clkinitstruct.APB2CLKDivider = RCC_HCLK_DIV1;
    clkinitstruct.APB1CLKDivider = RCC_HCLK_DIV2;
    if (HAL_RCC_ClockConfig(&clkinitstruct, FLASH_LATENCY_2) != HAL_OK) {
        while (1);
    }
}

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
