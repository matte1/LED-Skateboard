#include <embUnit/embUnit.h>
#include "drivers/sensors/bno055/bno055.h"

/*embunit:include=+ */
/*embunit:include=- */

static void setUp(void)
{
	/* initialize */
}

static void tearDown(void)
{
	/* terminate */
}

/*embunit:impl=+ */
static void testDeviceID(void)
{
	uint8_t ID;
	bno055ReadLength(BNO055_RA_DEV_ID, &ID, 1);
	TEST_ASSERT_EQUAL_INT(BNO055_ID, ID);
}

static void testInit(void)
{
	TEST_FAIL("no implementation");
}

/*embunit:impl=- */
TestRef BNO0555Tests_tests(void)
{
	EMB_UNIT_TESTFIXTURES(fixtures) {
	/*embunit:fixtures=+ */
		new_TestFixture("testDeviceID",testID),
		new_TestFixture("testInit",testInit),
	/*embunit:fixtures=- */
	};
	EMB_UNIT_TESTCALLER(BNO0555Tests,"BNO0555Tests",setUp,tearDown,fixtures);
	return (TestRef)&BNO0555Tests;
};
