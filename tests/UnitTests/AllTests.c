#include <embUnit/embUnit.h>
#include "textui/Outputter.h"
#include "textui/TextOutputter.h"
#include "textui/TextUIRunner.h"

#include "projectconfig.h"
#include "sysinit.h"

/*embunit:extern=+ */
extern TestRef BNO0555Tests_tests(void);
extern TestRef W25QXXTests_tests(void);
extern TestRef LEDTests_tests(void);
extern TestRef MTK3339Tests_tests(void);
extern TestRef ULOGFSTests_tests(void);
/*embunit:extern=- */

int main(int argc,char *argv[])
{
	/* Set Up Chip */
   systemInit();

	TextUIRunner_start();
	/*embunit:run=+ */
      #ifdef CFG_BRD_LPC1114_REFDESIGN
		  TextUIRunner_runTest(BNO0555Tests_tests());
        TextUIRunner_runTest(W25QXXTests_tests());
        TextUIRunner_runTest(MTK3339Tests_tests());
        TextUIRunner_runTest(ULOGFSTests_tests());
        TextUIRunner_runTest(LEDTests_tests());
      #endif

      

	/*embunit:run=- */
	TextUIRunner_end();
	return 0;
}
