#include <embUnit/embUnit.h>
/*embunit:include=+ */
#include "core/gpio/gpio.h"
#include "core/systick/systick.h"
/*embunit:include=- */

static void setUp(void)
{

}

static void tearDown(void)
{
	/* terminate */
}

/*embunit:impl=+ */
static void testToggle(void)
{
	gpioSetValue(CFG_LED_PORT, CFG_LED_PIN, 0);
	TEST_ASSERT_EQUAL_INT(gpioGetValue(CFG_LED_PORT, CFG_LED_PIN), 0);
	systickDelay(CFG_SYSTICK_100MS_DELAY*5);

	gpioSetValue(CFG_LED_PORT, CFG_LED_PIN, 1);
	TEST_ASSERT_EQUAL_INT(gpioGetValue(CFG_LED_PORT, CFG_LED_PIN), 1);
	systickDelay(CFG_SYSTICK_100MS_DELAY*5);

	gpioSetValue(CFG_LED_PORT, CFG_LED_PIN, 0);
	TEST_ASSERT_EQUAL_INT(gpioGetValue(CFG_LED_PORT, CFG_LED_PIN), 0);
}


/*embunit:impl=- */
TestRef LEDTests_tests(void)
{
	EMB_UNIT_TESTFIXTURES(fixtures) {
	/*embunit:fixtures=+ */
		new_TestFixture("testToggle",testToggle),
	/*embunit:fixtures=- */
	};

	EMB_UNIT_TESTCALLER(LEDTest,"LEDTest",setUp,tearDown,fixtures);
	return (TestRef)&LEDTest;
};
