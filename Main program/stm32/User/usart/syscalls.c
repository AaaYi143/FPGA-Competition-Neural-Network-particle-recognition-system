/**
 * @file    syscalls.c
 * @brief   GCC/newlib syscall retargeting for the bare-metal phone firmware.
 *
 * Keil + microlib redirects printf() through fputc(); GCC + newlib instead
 * calls _write(). This file provides _write/_read (routed to the debug USART
 * in bsp_debug_usart.c) plus the minimal heap/process/file stubs newlib needs
 * to link without an OS.
 */
#include <errno.h>
#include <sys/stat.h>
#include "stm32f1xx_hal.h"
#include "stm32f1xx_hal_uart.h"

extern UART_HandleTypeDef UartHandle;   /* defined in bsp_debug_usart.c */

/* ---- output: printf()/puts() funnel here -> USART1 ----------------------- */
int _write(int file, char *ptr, int len)
{
    (void)file;
    if (HAL_UART_Transmit(&UartHandle, (uint8_t *)ptr, (uint16_t)len, 0xFFFF) == HAL_OK)
        return len;
    return 0;
}

/* ---- input: scanf()/getchar() funnel here -> USART1 (blocking) ----------- */
int _read(int file, char *ptr, int len)
{
    (void)file;
    int got = 0;
    while (got < len) {
        if (HAL_UART_Receive(&UartHandle, (uint8_t *)(ptr + got), 1, 0xFFFF) != HAL_OK)
            break;
        got++;
    }
    return got;
}

/* ---- heap: grow from end of .bss (this app does not call malloc) --------- */
extern char end;                        /* defined by the linker script */

void *_sbrk(int incr)
{
    static char *heap_end = 0;
    char *prev;
    if (heap_end == 0)
        heap_end = &end;
    prev = heap_end;
    heap_end += incr;
    return (void *)prev;
}

/* ---- process/file stubs (newlib references some of these) ----------------- */
void _exit(int status)
{
    (void)status;
    while (1) { }
}

int _close(int file)                       { (void)file; errno = EBADF; return -1; }
int _fstat(int file, struct stat *st)      { (void)file; st->st_mode = S_IFCHR; return 0; }
int _isatty(int file)                      { (void)file; return 1; }
int _lseek(int file, int ptr, int dir)     { (void)file; (void)ptr; (void)dir; return 0; }
int _getpid(void)                          { return 1; }
int _kill(int pid, int sig)                { (void)pid; (void)sig; errno = EINVAL; return -1; }
