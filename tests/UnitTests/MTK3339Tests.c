#include <embUnit/embUnit.h>

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
static void testInit(void)
{
	TEST_FAIL("no implementation");
}

static void testParseRMC(void)
{
	TEST_FAIL("no implementation");
}

static void testParseGGA(void)
{
	TEST_FAIL("no implementation");
}

/*embunit:impl=- */
TestRef MTK3339Tests_tests(void)
{
	EMB_UNIT_TESTFIXTURES(fixtures) {
	/*embunit:fixtures=+ */
		new_TestFixture("testInit",testInit),
		new_TestFixture("testParseRMC",testParseRMC),
		new_TestFixture("testParseGGA",testParseGGA),
	/*embunit:fixtures=- */
	};
	EMB_UNIT_TESTCALLER(MTK3339Tests,"MTK3339Tests",setUp,tearDown,fixtures);
	return (TestRef)&MTK3339Tests;
};
