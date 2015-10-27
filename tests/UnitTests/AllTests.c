#include <embUnit/embUnit.h>
#include "textui/Outputter.h"
#include "textui/TextOutputter.h"
#include "textui/TextUIRunner.h"

#include "projectconfig.h"
#include "sysinit.h"

/*embunit:extern=+ */
extern TestRef BNO0555Tests_tests(void);
/*embunit:extern=- */

int main(int argc,char *argv[])
{
	/* Set Up Chip */
   systemInit();

	TextUIRunner_start();
	/*embunit:run=+ */
		TextUIRunner_runTest(BNO0555Tests_tests());
	/*embunit:run=- */
	TextUIRunner_end();
	return 0;
}
