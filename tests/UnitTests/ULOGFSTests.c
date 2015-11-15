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

/*embunit:impl=- */
TestRef ULOGFSTests_tests(void)
{
	EMB_UNIT_TESTFIXTURES(fixtures) {
	/*embunit:fixtures=+ */
		new_TestFixture("testInit",testInit),
	/*embunit:fixtures=- */
	};
	EMB_UNIT_TESTCALLER(ULOGFSTests,"ULOGFSTests",setUp,tearDown,fixtures);
	return (TestRef)&ULOGFSTests;
};
