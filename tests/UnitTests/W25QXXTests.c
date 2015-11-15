#include <embUnit/embUnit.h>
#include <string.h>
#include "drivers/flash/w25qxx/w25qxx.h"

/*embunit:include=+ */
/*embunit:include=- */

static void setUp(void)
{
	w25qEraseBlock(0);
}

static void tearDown(void)
{

}

/*embunit:impl=+ */
/* Tests abilitiy to Read Write data to a page. Fills a buffer of page size
 * with 0-PAGESIZE. Clears buffer, then reads data from flash and checks correct
 * values.
 */
static void testReadWritePage(void)
{
   int ndx;
   uint8_t buffer[W25Q_PAGESIZE];

   for (ndx = 0; ndx < 256; ndx++)
      buffer[ndx] = ndx;

   w25qWritePage(buffer, 0, 256);
   memset(buffer, 0x00, 256);
   w25qReadPage(buffer, 0);

   for (ndx = 0; ndx < 256; ndx++)
		TEST_ASSERT_EQUAL_INT(buffer[ndx], ndx);
}

static void testWriteEnable(void)
{
	TEST_FAIL("no implementation");
}

/* Reads device id from chip */
static void testDeviceID(void)
{
	TEST_ASSERT_EQUAL_INT(W25Q_DEVICE_ID, w25qReadDeviceID());
}

/*embunit:impl=- */
TestRef W25QXXTests_tests(void)
{
	EMB_UNIT_TESTFIXTURES(fixtures) {
	/*embunit:fixtures=+ */
		new_TestFixture("testReadWritePage",testReadWritePage),
		new_TestFixture("testWriteEnable",testWriteEnable),
		new_TestFixture("testDeviceID",testDeviceID),
	/*embunit:fixtures=- */
	};
	EMB_UNIT_TESTCALLER(W25QXXTests,"W25QXXTests",setUp,tearDown,fixtures);
	return (TestRef)&W25QXXTests;
};
