#include <embUnit/embUnit.h>

/*embunit:include=+ */
#include "drivers/scheduler/scheduler.h"
/*embunit:include=- */

/* Requirements
 * 1) Init tasks struct
 * 2) Schedule a single task
 * 2) Schedule two tasks
 * 3) Schedule n tasks
 * 4) Run scheduled tasks
 */

static void setUp(void)
{
	/* initialize */
}

static void tearDown(void)
{
	/* terminate */
}

/*embunit:impl=+ */
static void testInitTaskList(void)
{
	TEST_FAIL("no implementation");
}

/*embunit:impl=+ */
static void testScheduleOneTask(void)
{
	TEST_FAIL("no implementation");
}

/*embunit:impl=+ */
static void testSchedulerRunTasks(void)
{
	TEST_FAIL("no implementation");
}


/*embunit:impl=- */
TestRef SchedulerTests_tests(void)
{
	EMB_UNIT_TESTFIXTURES(fixtures) {
	/*embunit:fixtures=+ */
		new_TestFixture("testScheduleTask",testScheduleTask),
	/*embunit:fixtures=- */
	};
	EMB_UNIT_TESTCALLER(SchedulerTests,"SchedulerTests",setUp,tearDown,fixtures);
	return (TestRef)&SchedulerTests;
};
