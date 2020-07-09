#include "ddf_util"
#include "ddf_journal"


void main()
{
    SetLocalInt(GetModule(), "ddf_attempt_aladaras_basement", TRUE);
    UpdateJournal(GetPCSpeaker());
}
