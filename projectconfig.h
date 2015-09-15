/**************************************************************************/
/*!
    @file     projectconfig.h
    @author   K. Townsend (microBuilder.eu)

    @section LICENSE

    Software License Agreement (BSD License)

    Copyright (c) 2010, microBuilder SARL
    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:
    1. Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.
    2. Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.
    3. Neither the name of the copyright holders nor the
    names of its contributors may be used to endorse or promote products
    derived from this software without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ''AS IS'' AND ANY
    EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
    WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
    DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER BE LIABLE FOR ANY
    DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
    (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
    ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
    SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
/**************************************************************************/

#ifndef _PROJECTCONFIG_H_
#define _PROJECTCONFIG_H_

#include "lpc1xxx/lpc111x.h"
#include "sysdefs.h"

/*=========================================================================
    BOARD SELECTION

    Because several boards use this code library with sometimes slightly
    different pin configuration, you will need to specify which board you
    are using by enabling one of the following definitions. The code base
    will then try to configure itself accordingly for that board.
    -----------------------------------------------------------------------*/
    #define CFG_BRD_LPC1114_REFDESIGN
/*=========================================================================*/


/**************************************************************************

    This table tries to give an indication of which GPIO pins and
    peripherals are used by the available drivers and SW examples.  Only
    dedicated GPIO pins available on the LPC1114 Reference Board are shown
    below.  Any unused peripheral blocks like I2C, SSP, ADC, etc., can
    also be used as GPIO if they are available.

                PORT 0    PORT 1    PORT 2               PORT 3
                =======   ======    =================    ======
                3 11      2 8 9     4 5 6 7 8 9 10 11    1 2 3


                TIMERS                      SSP       ADC [0]       UART    I2C
                ======================      ===       ===========   ====    ===
                16B0  16B1  32B0  32B1      0 1       0 1 2 3 6 7   0       0
    BNO055      .     .     .     .         . X       . . . . . .   .       x
    BATTERY     .     .     .     .         . .       X . . . . .   .
 **************************************************************************/

/*=========================================================================
    FIRMWARE VERSION SETTINGS
    -----------------------------------------------------------------------*/
    #define CFG_FIRMWARE_VERSION_MAJOR            (0)
    #define CFG_FIRMWARE_VERSION_MINOR            (0)
    #define CFG_FIRMWARE_VERSION_REVISION         (0)
/*=========================================================================*/


/*=========================================================================
    CORE CPU SETTINGS
    -----------------------------------------------------------------------

    CFG_CPU_CCLK    Value is for reference only.  'core/cpu/cpu.c' must
                    be modified to change the clock speed, but the value
                    should be indicated here since CFG_CPU_CCLK is used by
                    other peripherals to determine timing.

    Note:           At 36MHz 1 tick = ~27.777ns or 0.02777us
    -----------------------------------------------------------------------*/
    #ifdef CFG_BRD_LPC1114_REFDESIGN
      #define CFG_CPU_CCLK              (36000000)
    #endif
/*=========================================================================*/


/*=========================================================================
    Power Management (PMU Settings)
    -----------------------------------------------------------------------

    CFG_PMU_USEPOWERPROFILES    If set to 1 LPC1100L power profiles will
                                be used, otherwise they will be ignored.
                                This should only be set for L-series chips.
    CFG_PMU_POWERPROFILE        The default power profile to use for normal
                                program execution.  This can be any of the
                                following value from core/pmu/pmu.h:

                                  pmuPowerProfile_Default
                                  pmuPowerProfile_Performance
                                  pmuPowerProfile_Efficiency
                                  pmuPowerProfile_LowCurrent

    Note: There is an internal check in the pmu code to make sure that the
    chip actually supports power profiles, so these can be safely enabled
    on non L series MCUs.
    -----------------------------------------------------------------------*/
    #ifdef CFG_BRD_LPC1114_REFDESIGN
      #define CFG_PMU_USEPOWERPROFILES  (1)
      #define CFG_PMU_POWERPROFILE      (pmuPowerProfile_Efficiency)
    #endif
/*=========================================================================*/


/*=========================================================================
    VOLTAGE REGULATOR
    -----------------------------------------------------------------------

    CFG_VREG_VCC_MAIN     Output voltage of the regulator in millivolts
    CFG_VREG_ALT_PRESENT  0 if no alternative voltage is available, 1
                          if it is available (TPS780, etc.)
    CFG_VREG_ALT_VCC      Alternate output voltage in millivolts on the
                          vreg in sleep or low-power mode.  (Only relevant
                          for dual-output regulators like the TPS780, etc.)
    CFG_VREG_ALT_PORT     GPIO port to enable alternate VREG output
    CFG_VREG_ALT_PIN      GPIO pin to enable alternate VREG output
    CFG_VREG_ALT_REG32    IOCON Register for the alt. output enable pin

    -----------------------------------------------------------------------*/
    #ifdef CFG_BRD_LPC1114_REFDESIGN
      #define CFG_VREG_VCC_MAIN         (3300)    // 3.3V * 1000
      #define CFG_VREG_ALT_PRESENT      (0)
      #define CFG_VREG_ALT_PRESENT      (0)
      #define CFG_VREG_ALT_VCC          (3300)
      #define CFG_VREG_ALT_PORT         (2)
      #define CFG_VREG_ALT_PIN          (10)
      #define CFG_VREG_ALT_REG32        (IOCON_PIO2_10)
    #endif
/*=========================================================================*/

/*=========================================================================
    SYSTICK TIMER
    -----------------------------------------------------------------------

    CFG_SYSTICK_DELAY_IN_MS   The number of milliseconds between each tick
                              of the systick timer.

    -----------------------------------------------------------------------*/
    #ifdef CFG_BRD_LPC1114_REFDESIGN
      #define CFG_SYSTICK_DELAY_IN_MS     (1)
      #define CFG_SYSTICK_100MS_DELAY     (100 / CFG_SYSTICK_DELAY_IN_MS)
    #endif
/*=========================================================================*/


/*=========================================================================
    GPIO INTERRUPTS
    -----------------------------------------------------------------------

    IF you wish to use the GPIO interrupt handlers elsewhere in your code,
    you should probably define a seperate IRQHandler for the appropriate
    GPIO bank rather than using the definitions in core/gpio/gpio.c (to
    avoid causing problems in other projects, and to make updates easier,
    etc.)  To disable the default IRQHandler, simply comment out the
    define below for the appropriate GPIO bank and implement the handler
    somewhere else.

    GPIO_ENABLE_IRQ0    If defined, PIOINT0_IRQHandler will be declared and
                        handled in core/gpio/gpio.c
    GPIO_ENABLE_IRQ1    If defined, PIOINT1_IRQHandler will be declared and
                        handled in core/gpio/gpio.c
    GPIO_ENABLE_IRQ2    If defined, PIOINT2_IRQHandler will be declared and
                        handled in core/gpio/gpio.c
    GPIO_ENABLE_IRQ3    If defined, PIOINT3_IRQHandler will be declared and
                        handled in core/gpio/gpio.c

    -----------------------------------------------------------------------*/
    #ifdef CFG_BRD_LPC1114_REFDESIGN
      // #define GPIO_ENABLE_IRQ0
      // #define GPIO_ENABLE_IRQ1
      // #define GPIO_ENABLE_IRQ2
      // #define GPIO_ENABLE_IRQ3
    #endif
/*=========================================================================*/


/*=========================================================================
    UART
    -----------------------------------------------------------------------

    CFG_UART_BAUDRATE         The default UART speed.  This value is used
                              when initialising UART, and should be a
                              standard value like 57600, 9600, etc.
    CFG_UART_BUFSIZE          The length in bytes of the UART RX FIFO. This
                              will determine the maximum number of received
                              characters to store in memory.

    -----------------------------------------------------------------------*/
    #ifdef CFG_BRD_LPC1114_REFDESIGN
      #define CFG_UART_BAUDRATE           (9600)
      #define CFG_UART_BUFSIZE            (128)
    #endif
/*=========================================================================*/


/*=========================================================================
    ADC
    -----------------------------------------------------------------------

    ADC_AVERAGING_ENABLE      To get better results, the ADC code can take
                              a number of samples and return the average
                              value.  This is slower, but can give more
                              accurate results compared to single-reading.

                              To enable averaging, set ADC_AVERAGING_ENABLE
                              to a non-zero value.
    ADC_AVERAGING_SAMPLES     The number of ADC samples to read and
                              average if ADC averaging is enabled.

    -----------------------------------------------------------------------*/
    #ifdef CFG_BRD_LPC1114_REFDESIGN
      #define ADC_AVERAGING_ENABLE    (1)
      #define ADC_AVERAGING_SAMPLES   (5)
    #endif
/*=========================================================================*/


/*=========================================================================
    ON-BOARD LED
    -----------------------------------------------------------------------

    CFG_LED_PORT              The port for the on board LED
    CFG_LED_PIN               The pin for the on board LED
    CFG_LED_ON                The pin state to turn the LED on (0 = low, 1 = high)
    CFG_LED_OFF               The pin state to turn the LED off (0 = low, 1 = high)

    -----------------------------------------------------------------------*/
    #ifdef CFG_BRD_LPC1114_REFDESIGN
      #define CFG_LED
      #define CFG_LED_PORT                (0)
      #define CFG_LED_PIN                 (10)
      #define CFG_LED_ON                  (1)
      #define CFG_LED_OFF                 (0)
    #endif
/*=========================================================================*/


/*=========================================================================
    BNO055
    -----------------------------------------------------------------------

    CFG_BNO055_DEBUG            If this is defined, a data read from
                                registers will be echo from printf to
                                the uart.

    DEPENDENCIES:               I2C
    -----------------------------------------------------------------------*/
    #ifdef CFG_BRD_LPC1114_REFDESIGN
      #define CFG_BNO055
      #define CFG_BNO055_DEBUG
    #endif
/*=========================================================================*/


/*=========================================================================
    MTK3339
    -----------------------------------------------------------------------
    DEPENDENCIES:               UART
    -----------------------------------------------------------------------*/
    #ifdef CFG_BRD_LPC1114_REFDESIGN
      // #define CFG_MTK3339
      // #define CFG_MTK3339_DEBUG
    #endif
/*=========================================================================*/


/*=========================================================================
    W25QXX
    -----------------------------------------------------------------------

    DEPENDENCIES:               SPI0
    -----------------------------------------------------------------------*/
    #ifdef CFG_BRD_LPC1114_REFDESIGN
      #define CFG_W25QXX
      #define CFG_W25QXX_MAX_ADDRESS (8388608UL)
      #define CFG_W25QXX_DEBUG
    #endif
/*=========================================================================*/

/*=========================================================================
    PRINTF REDIRECTION
    -----------------------------------------------------------------------

    CFG_PRINTF_UART           Will cause all printf statements to be
                              redirected to UART
    CFG_PRINTF_NEWLINE        This should be either "\r\n" for Windows or
                              "\n" for *nix

    Note: If no printf redirection definitions are present, all printf
    output will be ignored, though this will also save ~350 bytes flash.

    NOTE: PRINTF Support =    ~350 bytes Flash (-Os)
    -----------------------------------------------------------------------*/
    #ifdef CFG_BRD_LPC1114_REFDESIGN
      #define CFG_PRINTF_UART
      #define CFG_PRINTF_NEWLINE          "\r\n"
    #endif

/*=========================================================================*/

/*=========================================================================
    COMMAND LINE INTERFACE
    -----------------------------------------------------------------------

    CFG_INTERFACE             If this field is defined the UART or USBCDC
                              based command-line interface will be included
    CFG_INTERFACE_MAXMSGSIZE  The maximum number of bytes to accept for an
                              incoming command
    CFG_INTERFACE_PROMPT      The command prompt to display at the start
                              of every new data entry line

    NOTE:                     The command-line interface will use either
                              USB-CDC or UART depending on whether
                              CFG_PRINTF_UART or CFG_PRINTF_USBCDC are
                              selected.
    -----------------------------------------------------------------------*/
    #ifdef CFG_BRD_LPC1114_REFDESIGN
      #define CFG_INTERFACE
      #define CFG_INTERFACE_UART
      #define CFG_INTERFACE_MAXMSGSIZE    (256)
      #define CFG_INTERFACE_PROMPT        "LPC1114 >> "
    #endif
/*=========================================================================*/


/*=========================================================================
  CONFIG FILE VALIDATION
  -------------------------------------------------------------------------
  Basic error checking to make sure that incompatible defines are not
  enabled at the same time, etc.

  =========================================================================*/

#if !defined CFG_BRD_LPC1114_REFDESIGN && !defined CFG_BRD_LPC1114_802154WIRELESS
  #error "You must defined a target board (CFG_BRD_LPC1114_REFDESIGN or CFG_BRD_LPC1114_802154WIRELESS)"
#endif

#endif
