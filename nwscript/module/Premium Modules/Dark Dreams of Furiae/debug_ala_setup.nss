#include "ddf_util"

void main()
{
    debug("-- setup for day 4 aladara apartment investigation.");
    IncrementDay();
    IncrementDay();
    IncrementDay();

    SetLocalInt(GetModule(), "ddf_examined_grimy_ledger", TRUE);

    IncrementDay();
}
