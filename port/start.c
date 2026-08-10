#include "FreeRTOS.h"
#include "task.h"

static void vTask1(void *pvParameters) {
    volatile int a = 0;
    while(1){
        a++;
    };
}
static void vTask2(void *pvParameters) {
    volatile int b = 0;
    while(1){
        b++;
    };
}

extern uint32_t _sdata;   // start of .data section in RAM (destination)
extern uint32_t _edata;   // end of .data section in RAM (destination)
extern uint32_t _sidata;  // start of .data's initial values in FLASH (load address / source)
extern uint32_t _sbss;    // start of .bss section in RAM
extern uint32_t _ebss;    // end of .bss section in RAM

void start()
{
    BaseType_t xReturn;

    uint32_t *src =&_sidata; //source (flash)
    uint32_t *dst =&_sdata; //desatination flash (RAM)

    while(dst < &_edata){
        *dst++ = *src++; //copy word and incremtn ptr
    }

    //intialize .bss section (zero out)
    dst= &_sbss;
    while(dst < &_ebss){
        *dst++ = 0;// zero word and increment ptr
    }



    xReturn = xTaskCreate(vTask1, "T1", configMINIMAL_STACK_SIZE, NULL, 1, NULL);
    xReturn = xTaskCreate(vTask2, "T2", configMINIMAL_STACK_SIZE, NULL, 1, NULL);
    portENABLE_INTERRUPTS();
    xPortStartScheduler();
    return;
}